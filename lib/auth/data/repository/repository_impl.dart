import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../shared/shared.export.dart';
import '../datasource/datasource_impl.dart';

part 'repository.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  final AuthDataSource _authDataSource;
  final StorageDataSource _storageDataSource;

  AuthRepositoryImpl(
      {required AuthDataSource authDataSource,
      required StorageDataSource storageDataSource})
      : _authDataSource = authDataSource,
        _storageDataSource = storageDataSource;

  @override
  Future<ResponseWrapper<User?>> signUpWithEmailAndPassword(
      {required String email,
      required String password,
      required String username,
      required String avatarUrl}) async {
    try {
      return await _authDataSource
          .signUpWithEmailAndPassword(
              email: email,
              password: password,
              username: username,
              avatarUrl: avatarUrl)
          .then(SuccessResponse<User?>.from);
    } on Exception catch (error) {
      return ErrorResponse<User?>.from(error);
    }
  }

  @override
  Future<ResponseWrapper<User?>> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _authDataSource
          .signInWithEmailAndPassword(email, password)
          .then(SuccessResponse<User?>.from);
    } on Exception catch (error) {
      return ErrorResponse<User?>.from(error);
    }
  }

  @override
  Future<ResponseWrapper<String>> uploadProfileImage(File profileImage) async {
    try {
      return await _storageDataSource
          .uploadImage(
              file: profileImage,
              bucketName: Buckets.avatars.name,
              upsert: true)
          .then(SuccessResponse<String>.from);
    } on Exception catch (error) {
      return ErrorResponse<String>.from(error);
    }
  }

  @override
  Future<ResponseWrapper<void>> signOut() async {
    try {
      return await _authDataSource.signOut().then(SuccessResponse<void>.from);
    } on Exception catch (error) {
      return ErrorResponse<void>.from(error);
    }
  }

  @override
  Stream<User?> get userStream => _authDataSource.authStream
      .asyncMap((authState) => authState.session?.user);

  @override
  User? get currentUser => _authDataSource.currentUser;

  @override
  Future<ResponseWrapper<void>> updateMetaData(
      {String? username, String? avatarUrl}) async {
    try {
      return await _authDataSource
          .updateMetaData(username: username, avatarUrl: avatarUrl)
          .then(SuccessResponse<void>.from);
    } on Exception catch (error) {
      return ErrorResponse<void>.from(error);
    }
  }
}
