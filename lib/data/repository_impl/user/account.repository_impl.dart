import 'dart:io';
import 'package:fpdart/src/either.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/core/exception/custom_exception.dart';
import 'package:my_app/core/exception/failure.dart';
import 'package:my_app/data/entity/user/account.entity.dart';
import 'package:my_app/domain/model/user/account.model.dart';
import '../../datasource/user/account/account.datasource_impl.dart';

part 'package:my_app/domain/repository/user/account.repository.dart';

@Singleton(as: AccountRepository)
class AccountRepositoryImpl implements AccountRepository {
  final RemoteAccountDataSource _remoteDataSource;

  AccountRepositoryImpl({required RemoteAccountDataSource remoteUserDataSource})
      : _remoteDataSource = remoteUserDataSource;

  @override
  Future<Either<Failure, AccountEntity>> getCurrentUser() async {
    try {
      return await _remoteDataSource
          .getCurrentUser()
          .then((model) => AccountEntity.fromModel(model))
          .then(right);
    } on CustomException catch (error) {
      return left(Failure(code: error.code, message: error.message));
    }
  }

  @override
  Future<Either<Failure, void>> upsertUser(AccountEntity entity) async {
    try {
      return await _remoteDataSource
          .upsertUser(AccountModel.fromEntity(entity))
          .then(right);
    } on CustomException catch (error) {
      return left(Failure(code: error.code, message: error.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteUser() async {
    try {
      return await _remoteDataSource.deleteUser().then(right);
    } on CustomException catch (error) {
      return left(Failure(code: error.code, message: error.message));
    }
  }

  @override
  Future<Either<Failure, bool>> checkIsDuplicatedNickname(
      String nickname) async {
    try {
      return await _remoteDataSource
          .checkIsDuplicatedNickname(nickname)
          .then(right);
    } on CustomException catch (error) {
      return left(Failure(code: error.code, message: error.message));
    }
  }

  @override
  Future<Either<Failure, String>> getProfileImageDownloadUrl() async {
    try {
      return await _remoteDataSource.getProfileImageDownloadUrl().then(right);
    } on CustomException catch (error) {
      return left(Failure(code: error.code, message: error.message));
    }
  }

  @override
  Future<Either<Failure, void>> saveProfileImage(File image) async {
    try {
      return await _remoteDataSource.saveProfileImage(image).then(right);
    } on CustomException catch (error) {
      return left(Failure(code: error.code, message: error.message));
    }
  }
}
