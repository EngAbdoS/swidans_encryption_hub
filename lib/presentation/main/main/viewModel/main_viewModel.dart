import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flu_proj/presentation/base/base_view_model.dart';
import 'package:flu_proj/presentation/encryption_algorithms/autoKey.dart';
import 'package:flu_proj/presentation/encryption_algorithms/caesar.dart';
import 'package:flu_proj/presentation/encryption_algorithms/des.dart';
import 'package:flu_proj/presentation/encryption_algorithms/monoAlphapitec.dart';
import 'package:flu_proj/presentation/encryption_algorithms/playfair.dart';
import 'package:flu_proj/presentation/encryption_algorithms/polyalphabetic.dart';
import 'package:flu_proj/presentation/encryption_algorithms/realfence.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../app/app_prefs.dart';
import '../../../../app/di.dart';
import '../../../../data/data_source/local_data_source.dart';
import '../../../../domain/models/models.dart';
import '../../../resourses/router_manager.dart';

class MainViewModel extends BaseViewModel
    with MainViewModelInputs, MainViewModelOutputs {
  final LocalDataSource _localDataSource = instance<LocalDataSource>();
  final AppPreferences _appPreferences = instance<AppPreferences>();

  UserDataModel? userDataModel;

  final StreamController _messageStreamController = BehaviorSubject<String>();
  final StreamController _algorithmStreamController = BehaviorSubject<String>();
  final StreamController _userKeyStreamController = BehaviorSubject<String>();
  final StreamController _generatedKeyStreamController =
      BehaviorSubject<String?>();
  final StreamController _userKeyStateStreamController =
      BehaviorSubject<bool>();
  final StreamController _encryptionResultStreamController =
      BehaviorSubject<String?>();
  final StreamController _areAllInputValidStreamController =
      BehaviorSubject<void>();
  final MonoalphabeticAlgorithm _monoalphabeticAlgorithm =
      MonoalphabeticAlgorithm();
  final StreamController _profilePicStreamController =
      BehaviorSubject<String>();

  final CaesarAlgorithm _caesarAlgorithm = CaesarAlgorithm();
  final PlayfairAlgorithm _playfairAlgorithm = PlayfairAlgorithm();
  final PolyalphabeticAlgorithm _polyalphabeticAlgorithm =
      PolyalphabeticAlgorithm();
  final AutoKeyAlgorithm _autoKeyAlgorithm = AutoKeyAlgorithm();
  final RealFenceAlgorithm _realFenceAlgorithm = RealFenceAlgorithm();
  final DESAlgorithm _desAlgorithm = DESAlgorithm();
  String userMessage = "";
  String userKey = "";
  int index = 0;
  bool willUserEnterKey = false;
  File? profilePic;
  List<String> algorithms = [
    "Monoaphpetic",
    "Caesar",
    "Playfair",
    "Polyalphabetic",
    "Autokey",
    "Realfence",
    "DES",
  ];

  @override
  void start() {
    //inputState.add(ContentState());
    _getUserData();
  }

  @override
  void dispose() {
    super.dispose();
    _messageStreamController.close();
    _algorithmStreamController.close();
    _areAllInputValidStreamController.close();
    _userKeyStreamController.close();
    _generatedKeyStreamController.close();
    _userKeyStateStreamController.close();
    _encryptionResultStreamController.close();
  }

  @override
  Sink get areAllInputsValid => _areAllInputValidStreamController.sink;

  @override
  Stream<bool> get outputAreAllInputsValid =>
      _areAllInputValidStreamController.stream.map((validation) => validation);

  _areAllInputValid() {
    areAllInputsValid
        .add((_userKeyValidation(userKey) && _messageValidation(userMessage)));
  }

  @override
  Sink get inputAlgorithm => _algorithmStreamController.sink;

  @override
  Sink get inputMessage => _messageStreamController.sink;

  @override
  Stream<String> get outputAlgorithm =>
      _algorithmStreamController.stream.map((algorithm) => algorithm);

  bool _userKeyValidation(String userKey) {
    if (willUserEnterKey) {
      switch (index) {
        case 0:
          return _monoalphabeticAlgorithm.keyValidation(userKey);
        case 1:
          return _caesarAlgorithm.keyValidation(userKey);
        case 2:
          return _playfairAlgorithm.keyValidation(userKey);
        case 3:
          return _polyalphabeticAlgorithm.keyValidation(userKey);
        case 4:
          return _autoKeyAlgorithm.keyValidation(userKey);
        case 5:
          return _realFenceAlgorithm.keyValidation(userKey, userMessage);
        case 6:
          return _desAlgorithm.keyValidation(userKey);
        default:
          return false; //TODO edit
      }
    } else {
      return true;
    }
  }

  @override
  Stream<bool> get outputIsMessageValid => _messageStreamController.stream
      .map((message) => _messageValidation(message));

  bool _messageValidation(String message) {
    //TODO message validation
    return message.isNotEmpty;
  }

  @override
  setAlgorithm(int index) {
    // inputState.add(LoadingState(stateRendererType: StateRendererType.popupLoadingState));
    this.index = index;
    (index == 2 ||
            index == 3 ||
            index == 4 ||
            index == 6) //  have not auto generate key
        ? setKeyState(true)
        : setKeyState(false); //////////////////////////////////////////
    inputAlgorithm.add(algorithms[index]);
    inputEncryptionResult.add(null);
    setUserKey("");
    // inputGeneratedKey.add(null);
    _areAllInputValid();
  }

  @override
  setMessage(String message) {
    inputMessage.add(message);
    userMessage = message;
    _areAllInputValid();
  }

  @override
  getEncode() {
    switch (index) {
      case 0:
        {
          inputEncryptionResult.add(_monoalphabeticAlgorithm.encode(
              userMessage, willUserEnterKey, userKey));
          //add generated key to view stream
          !willUserEnterKey
              ? setGeneratedKey(_monoalphabeticAlgorithm.userGeneratedKey)
              : {};
          break;
        }
      case 1:
        {
          inputEncryptionResult.add(
              _caesarAlgorithm.encode(userMessage, willUserEnterKey, userKey));
          //add generated key to view stream
          !willUserEnterKey
              ? setGeneratedKey(_caesarAlgorithm.userGeneratedKey.toString())
              : {};
          break;
        }
      case 2: /////////////////////////////////////////////////////////////
        {
          inputEncryptionResult
              .add(_playfairAlgorithm.encode(userMessage, userKey));

          break;
        }
      case 3:
        {
          inputEncryptionResult
              .add(_polyalphabeticAlgorithm.encode(userMessage, userKey));

          break;
        }
      case 4:
        {
          inputEncryptionResult
              .add(_autoKeyAlgorithm.encode(userMessage, userKey));

          break;
        }
      case 5:
        {
          inputEncryptionResult.add(_realFenceAlgorithm.encode(
              userMessage, willUserEnterKey, userKey));
          //add generated key to view stream
          !willUserEnterKey
              ? setGeneratedKey(_realFenceAlgorithm.userGeneratedKey.toString())
              : {};
          break;
        }
      case 6:
        {
          inputEncryptionResult.add(_desAlgorithm.encode(userMessage, userKey));
          break;
        }
    }
  }

  @override
  getDecode() {
    switch (index) {
      case 0:
        {
          inputEncryptionResult.add(_monoalphabeticAlgorithm.decode(
              userMessage, willUserEnterKey, userKey));
          break;
        }
      case 1:
        {
          inputEncryptionResult.add(
              _caesarAlgorithm.decode(userMessage, willUserEnterKey, userKey));
          break;
        }
      case 2:
        {
          inputEncryptionResult
              .add(_playfairAlgorithm.decode(userMessage, userKey));
          break;
        }
      case 3:
        {
          inputEncryptionResult
              .add(_polyalphabeticAlgorithm.decode(userMessage, userKey));
          break;
        }
      case 4:
        {
          inputEncryptionResult
              .add(_autoKeyAlgorithm.decode(userMessage, userKey));
          break;
        }
      case 5:
        {
          inputEncryptionResult
              .add(_realFenceAlgorithm.decode(userMessage, userKey));
          break;
        }
      case 6:
        {
          inputEncryptionResult.add(_desAlgorithm.decode(userMessage, userKey));
          break;
        }
    }
  }

  @override
  setUserKey(String userKey) {
    inputUserKey.add(userKey);
    this.userKey = userKey;
    _areAllInputValid();
  }

  @override
  Sink get inputUserKey => _userKeyStreamController.sink;

  @override
  Stream<bool> get outputIsUserKeyValid => _userKeyStreamController.stream
      .map((userKey) => _userKeyValidation(userKey));

  @override
  Sink get inputUserKeyState => _userKeyStateStreamController.sink;

  @override
  Stream<bool> get outputUserKeyState =>
      _userKeyStateStreamController.stream.map((key) => key);

  @override
  setKeyState(bool userKeyState) {
    inputUserKeyState.add(userKeyState);
    willUserEnterKey = userKeyState;
    _areAllInputValid();
  }

  @override
  Sink get inputEncryptionResult => _encryptionResultStreamController.sink;

  @override
  Stream<String?> get outputEncryptionResult =>
      _encryptionResultStreamController.stream.map((result) => result);

  @override
  Sink get inputGeneratedKey => _generatedKeyStreamController.sink;

  @override
  Stream<String?> get outputGeneratedKey =>
      _generatedKeyStreamController.stream.map((key) => key);

  @override
  setGeneratedKey(String key) {
    inputGeneratedKey.add(key);
    _areAllInputValid();
  }

  _getUserData() async {
    userDataModel = await _localDataSource.getUserData();
    inputUserImage.add(userDataModel!.profilePicture);
  }

  changeLanguage(BuildContext context) {
    _appPreferences.changeAppLanguage();
    Phoenix.rebirth(context);
  }

  logout(BuildContext context) {
    //TODO study ...
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _appPreferences.logout();
      _localDataSource.clearCache();
      Navigator.of(context).pushReplacementNamed(Routes.loginRoute);
      //   _viewModel.dispose();
      //  super.dispose();
      dispose();
      print("scedjual dis");
    });
    // Navigator.of(context).pushReplacementNamed(Routes.loginRoute);
    // _viewModel.dispose();
    // super.dispose();
    // dispose();
    // print("diiiiiiiiiiiiiiiiiiiiiiiiiiis");
    //Navigator.pushReplacementNamed(context, Routes.loginRoute);
  }

  @override
  Sink get inputUserImage => _profilePicStreamController.sink;

  @override
  Stream<String> get outputUserImage => _profilePicStreamController.stream
      .map((profilePicture) => profilePicture);

  setProfilePicture(File profilePicture, BuildContext context) async {
    profilePic = profilePicture;
    var storageRef =
        FirebaseStorage.instance.ref().child(userDataModel!.name ?? "unKnown");
    await storageRef.putFile(profilePicture);

    await storageRef.getDownloadURL().then((imageURL) => {
          print("get itttt"),
          inputUserImage.add(imageURL),
          //update data base
          FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .set({"profilePicture": imageURL}, SetOptions(merge: true))
        });
    await _getUserData();
    Phoenix.rebirth(context);
  }

  setUserName() async {}
}

abstract class MainViewModelInputs {
  Sink get inputMessage;

  Sink get inputUserKey;

  Sink get inputUserKeyState;

  Sink get inputGeneratedKey;

  Sink get inputEncryptionResult;

  Sink get inputAlgorithm;

  Sink get areAllInputsValid;

  Sink get inputUserImage;

  setMessage(String message);

  setAlgorithm(int index);

  setGeneratedKey(String key);

  setUserKey(String userKey);

  getEncode();

  setKeyState(bool userKeyState);

  getDecode();
}

abstract class MainViewModelOutputs {
  Stream<bool> get outputIsMessageValid;

  Stream<bool> get outputIsUserKeyValid;

  Stream<String?> get outputGeneratedKey;

  Stream<bool> get outputUserKeyState;

  Stream<String?> get outputEncryptionResult;

  Stream<String> get outputAlgorithm;

  Stream<bool> get outputAreAllInputsValid;

  Stream<String> get outputUserImage;
}
