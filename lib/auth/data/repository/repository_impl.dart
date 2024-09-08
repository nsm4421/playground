import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../shared/constant/constant.export.dart';
import '../datasource/datasource_impl.dart';

part 'repository.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  final AuthDataSource _dataSource;

  AuthRepositoryImpl(this._dataSource);

  @override
  Future<RepositoryResponseWrapper<User?>> signUpWithEmailAndPassword(
      {required String email,
      required String password,
      required String username,
      required String avatarUrl}) async {
    try {
      return await _dataSource
          .signUpWithEmailAndPassword(
              email: email,
              password: password,
              username: username,
              avatarUrl: avatarUrl)
          .then(RepositorySuccess.from);
    } on Exception catch (error) {
      return RepositoryError.from(error);
    }
  }

  @override
  Future<RepositoryResponseWrapper<User?>> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _dataSource
          .signInWithEmailAndPassword(email, password)
          .then(RepositorySuccess.from);
    } on Exception catch (error) {
      return RepositoryError.from(error);
    }
  }

  @override
  Future<RepositoryResponseWrapper<bool>> checkUsername(String username) async {
    try {
      return await _dataSource.checkUsername(username).then(RepositorySuccess.from);
    } on Exception catch (error) {
      return RepositoryError.from(error);
    }
  }

  @override
  Future<RepositoryResponseWrapper<String>> uploadProfileImage(File profileImage) async {
    try {
      return await _dataSource
          .uploadProfileImage(profileImage)
          .then(RepositorySuccess.from);
    } on Exception catch (error) {
      return RepositoryError.from(error);
    }
  }

  @override
  Future<RepositoryResponseWrapper<void>> signOut() async {
    try {
      return await _dataSource.signOut().then(RepositorySuccess.from);
    } on Exception catch (error) {
      return RepositoryError.from(error);
    }
  }

  @override
  Stream<User?> get userStream =>
      _dataSource.authStream.asyncMap((authState) => authState.session?.user);

  @override
  User? get currentUser => _dataSource.currentUser;
}
