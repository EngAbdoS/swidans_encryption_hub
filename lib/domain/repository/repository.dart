import 'package:firebase_auth/firebase_auth.dart';

import '../../data/network/failure.dart';
import '../../data/network/requests.dart';
import 'package:dartz/dartz.dart';


abstract class Repository {
  Future<Either<Failure, UserCredential>> login(LoginRequest loginRequest);


  Future<Either<Failure, UserCredential>> register(
      RegisterRequest registerRequest);



}
