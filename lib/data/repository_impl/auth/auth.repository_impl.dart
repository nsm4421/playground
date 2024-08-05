import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:portfolio/data/model/auth/account.model.dart';
import 'package:portfolio/domain/entity/auth/account.entity.dart';
import 'package:portfolio/domain/entity/auth/presence.entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constant/response_wrapper.dart';
import '../../datasource/auth/abstract/auth.datasource.dart';

part '../../../domain/repository/auth/auth.repository.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _dataSource;
  final Logger _logger = Logger();

  AuthRepositoryImpl(this._dataSource);

  @override
  User? get currentUser => _dataSource.currentUser;

  @override
  Stream<AuthState> get authStream => _dataSource.authStream;

  @override
  Future<ResponseWrapper<User>> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final user =
          await _dataSource.signInWithEmailAndPassword(email, password);
      return user == null
          ? ResponseWrapper.error('auth response is not valid')
          : ResponseWrapper.success(user);
    } on AuthException catch (error) {
      _logger.e(error);
      return ResponseWrapper.error(error.message);
    } catch (error) {
      _logger.e(error);
      return ResponseWrapper.error('sign in fail');
    }
  }

  @override
  Future<ResponseWrapper<User>> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      final user =
          await _dataSource.signUpWithEmailAndPassword(email, password);
      return user == null
          ? ResponseWrapper.error('auth response is not valid')
          : ResponseWrapper.success(user);
    } on AuthException catch (error) {
      _logger.e(error);
      return ResponseWrapper.error(error.message);
    } catch (error) {
      _logger.e(error);
      return ResponseWrapper.error(
          (error is AuthException) ? error.message : 'sign up fail');
    }
  }

  @override
  Future<ResponseWrapper<void>> signOut() async {
    try {
      return await _dataSource.signOut().then(ResponseWrapper.success);
    } on AuthException catch (error) {
      _logger.e(error);
      return ResponseWrapper.error(error.message);
    } catch (error) {
      _logger.e(error);
      return ResponseWrapper.error('sign out fail');
    }
  }

  @override
  Future<ResponseWrapper<void>> insertAccount(AccountEntity entity) async {
    try {
      return await _dataSource
          .insertAccount(AccountModel.fromEntity(entity))
          .then(ResponseWrapper.success);
    } on PostgrestException catch (error) {
      _logger.e(error);
      return ResponseWrapper.error(error.message);
    } catch (error) {
      _logger.e(error);
      return ResponseWrapper.error('insert account fail');
    }
  }

  @override
  Future<ResponseWrapper<User>> updateMetaData(
      {String? nickname, String? profileImage}) async {
    try {
      final user = await _dataSource.updateMetaData(
          nickname: nickname, profileImage: profileImage);
      return user == null
          ? ResponseWrapper.error('update metadata fail')
          : ResponseWrapper.success(user);
    } on AuthException catch (error) {
      _logger.e(error);
      return ResponseWrapper.error(error.message);
    } catch (error) {
      _logger.e(error);
      return ResponseWrapper.error('update metadata fail');
    }
  }

  @override
  Future<ResponseWrapper<void>> updateAccount(
      {required String uid, String? nickname, String? profileImage}) async {
    try {
      return await _dataSource
          .updateAccount(
              uid: uid, nickname: nickname, profileImage: profileImage)
          .then(ResponseWrapper.success);
    } on PostgrestException catch (error) {
      _logger.e(error);
      return ResponseWrapper.error(error.message);
    } catch (error) {
      _logger.e(error);
      return ResponseWrapper.error('update account fail');
    }
  }

  @override
  Future<ResponseWrapper<String>> upsertProfileImage(
      {required String uid, required File profileImage}) async {
    try {
      return await _dataSource
          .upsertProfileImage(uid: uid, profileImage: profileImage)
          .then(ResponseWrapper.success);
    } on StorageException catch (error) {
      _logger.e(error);
      return ResponseWrapper.error(error.message);
    } catch (error) {
      _logger.e(error);
      return ResponseWrapper.error('upsert profile image fail');
    }
  }

  @override
  Future<ResponseWrapper<PresenceEntity>> findByUid(String uid) async {
    try {
      return await _dataSource
          .findByUid(uid)
          .then(PresenceEntity.fromModel)
          .then(ResponseWrapper.success);
    } on PostgrestException catch (error) {
      _logger.e(error);
      return ResponseWrapper.error(error.message);
    } catch (error) {
      _logger.e(error);
      return ResponseWrapper.error('find by uid fail');
    }
  }
}
