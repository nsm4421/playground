import 'dart:async';

import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/core/exception/failure.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/exception/custom_exception.dart';
import '../../datasource/user/impl/auth.remote_datasource_impl.dart';

part 'package:my_app/domain/repository/user/auth.repository.dart';

@Singleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final RemoteAuthDataSource _remoteDataSource;

  AuthRepositoryImpl({required RemoteAuthDataSource remoteAuthDataSource})
      : _remoteDataSource = remoteAuthDataSource;

  @override
  User? get currentUser => _remoteDataSource.currentUser;

  @override
  Stream<User?> get authStream => _remoteDataSource.authStream.asyncMap((data) {
        switch (data.event) {
          case AuthChangeEvent.initialSession:
          case AuthChangeEvent.signedIn:
          case AuthChangeEvent.passwordRecovery:
          case AuthChangeEvent.tokenRefreshed:
          case AuthChangeEvent.userUpdated:
          case AuthChangeEvent.mfaChallengeVerified:
            return data.session?.user;
          case AuthChangeEvent.signedOut:
          case AuthChangeEvent.userDeleted:
            return null;
        }
      });

  @override
  Future<Either<Failure, User?>> signInWithGoogle() async {
    try {
      return await _remoteDataSource.signInWithGoogle().then((r) => right(r));
    } on CustomException catch (error) {
      return left(Failure(code: error.code, message: error.message));
    }
  }

  @override
  Future<Either<Failure, User?>> signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      return await _remoteDataSource
          .signUpWithEmailAndPassword(email: email, password: password)
          .then((r) => right(r));
    } on CustomException catch (error) {
      return left(Failure(code: error.code, message: error.message));
    }
  }

  @override
  Future<Either<Failure, User?>> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      return await _remoteDataSource
          .signInWithEmailAndPassword(email: email, password: password)
          .then((r) => right(r));
    } on CustomException catch (error) {
      return left(Failure(code: error.code, message: error.message));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      return await _remoteDataSource.signOut().then((_) => right(null));
    } on CustomException catch (error) {
      return left(Failure(code: error.code, message: error.message));
    }
  }
}
