import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flu_proj/domain/models/models.dart';

abstract class RemoteDataSource {


  Future<UserDataModel> getUserData(String uID);
}

class RemoteDataSourceIml implements RemoteDataSource {



  @override
  Future<UserDataModel> getUserData(String uID) async {
    print("user id id $uID");
   late UserDataModel userData;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uID)
        .get()
        .then((user) {

          print(user.data());
      userData = UserDataModel.fromJson(user.data()!);
    });
    print(userData.name);
    print(userData.profilePicture);
    print(userData.password);
    print(userData.isVerefide);
    print(userData.countryMobileCode);
    print(userData.mobileNumber);
    return userData;
  }
}
