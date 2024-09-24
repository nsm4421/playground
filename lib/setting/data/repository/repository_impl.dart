import 'dart:io';

import 'package:flutter_app/auth/auth.export.dart';
import 'package:flutter_app/setting/data/datasource/datasource_impl.dart';
import 'package:flutter_app/shared/shared.export.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

part 'repository.dart';

@LazySingleton(as: AccountRepository)
class AccountRepositoryImpl extends AccountRepository {
  final AuthDataSource _authDataSource;
  final AccountDataSource _accountDataSource;
  final StorageDataSource _storageDataSource;
  final Logger _logger = Logger();

  AccountRepositoryImpl(
      {required AuthDataSource authDataSource,
      required AccountDataSource accountDataSource,
      required StorageDataSource storageDataSource})
      : _authDataSource = authDataSource,
        _accountDataSource = accountDataSource,
        _storageDataSource = storageDataSource;

  @override
  Future<ResponseWrapper<void>> checkUsername(String username) async {
    try {
      return await _accountDataSource.checkUsername(username).then((res) =>
          res ? const SuccessResponse<void>() : const ErrorResponse<void>());
    } on Exception catch (error) {
      _logger.e(error);
      return ErrorResponse<void>.from(error);
    }
  }

  @override
  Future<ResponseWrapper<void>> updateAccount(
      {String? username, String? avatarUrl}) async {
    try {
      await _accountDataSource.updateAccount(
          username: username, avatarUrl: avatarUrl);
      await _authDataSource.updateMetaData(
          username: username, avatarUrl: avatarUrl);
      return const SuccessResponse<void>();
    } on Exception catch (error) {
      _logger.e(error);
      return ErrorResponse<void>.from(error);
    }
  }

  @override
  Future<ResponseWrapper<String>> editProfileImage(File profileImage) async {
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
}
