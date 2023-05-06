import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flu_proj/data/data_source/local_data_source.dart';
import 'package:flu_proj/data/network/error_handler.dart';
import 'package:flu_proj/data/network/failure.dart';
import 'package:flu_proj/data/network/requests.dart';
import 'package:flu_proj/domain/repository/repository.dart';
import 'package:flutter/foundation.dart';
import '../network/network_info.dart';

class RepositoryImp implements Repository {
  final LocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  RepositoryImp(
      this._networkInfo, this._localDataSource);

  @override
  Future<Either<Failure, UserCredential>> login(
      LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        var userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: loginRequest.email, password: loginRequest.password);

//TODO return right
        return Right(userCredential);
      } on FirebaseAuthException catch (error) {
        //TODO firebase error handler
        print(error);
        return Left(ErrorHandler.handle(error).failure);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, UserCredential>> register(
      RegisterRequest registerRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        var userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: registerRequest.email,
                password: registerRequest.password);
        registerRequest.uId = userCredential.user!.uid;
        FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set(registerRequest.tpMap());
//TODO return right
        return Right(userCredential);
      } on FirebaseAuthException catch (error) {
        //TODO firebase error handler
        print(error);
        return Left(ErrorHandler.handle(error).failure);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }


}
