import 'dart:io';

import 'package:flutter_app/auth/data/datasource/datasource_impl.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'repository.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  final AuthDataSource _dataSource;

  AuthRepositoryImpl(this._dataSource);
  @override
  Future<User?> signUpWithEmailAndPassword(
      {required String email,
      required String password,
      required String username,
      required String avatarUrl}) async {
    return await _dataSource.signUpWithEmailAndPassword(
        email: email,
        password: password,
        username: username,
        avatarUrl: avatarUrl);
  }

  @override
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    return await _dataSource.signInWithEmailAndPassword(email, password);
  }

  @override
  Future<bool> checkUsername(String username) async {
    return await _dataSource.checkUsername(username);
  }

  @override
  Future<String> uploadProfileImage(File profileImage) async {
    return await _dataSource.uploadProfileImage(profileImage);
  }
}
