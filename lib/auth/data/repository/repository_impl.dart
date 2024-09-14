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
  Future<RepositoryResponseWrapper<User?>> signUpWithEmailAndPassword(
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
          .then(RepositorySuccess<User?>.from);
    } on Exception catch (error) {
      return RepositoryError<User?>.from(error);
    }
  }

  @override
  Future<RepositoryResponseWrapper<User?>> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _authDataSource
          .signInWithEmailAndPassword(email, password)
          .then(RepositorySuccess<User?>.from);
    } on Exception catch (error) {
      return RepositoryError<User?>.from(error);
    }
  }

  @override
  Future<RepositoryResponseWrapper<bool>> checkUsername(String username) async {
    try {
      return await _authDataSource
          .checkUsername(username)
          .then(RepositorySuccess<bool>.from);
    } on Exception catch (error) {
      return RepositoryError<bool>.from(error);
    }
  }

  @override
  Future<RepositoryResponseWrapper<String>> uploadProfileImage(
      File profileImage) async {
    try {
      return await _storageDataSource
          .uploadImage(
              file: profileImage,
              bucketName: Buckets.avatars.name,
              upsert: true)
          .then(RepositorySuccess<String>.from);
    } on Exception catch (error) {
      return RepositoryError<String>.from(error);
    }
  }

  @override
  Future<RepositoryResponseWrapper<void>> signOut() async {
    try {
      return await _authDataSource.signOut().then(RepositorySuccess<void>.from);
    } on Exception catch (error) {
      return RepositoryError<void>.from(error);
    }
  }

  @override
  Stream<User?> get userStream => _authDataSource.authStream
      .asyncMap((authState) => authState.session?.user);

  @override
  User? get currentUser => _authDataSource.currentUser;
}
