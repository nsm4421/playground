import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/custom_exception.dart';
import '../../../core/error/failure.constant.dart';
import '../../../domain/model/user/user.model.dart';
import '../../../domain/repository/user/user.repository.dart';
import '../../data_source/user/remote_data_source.dart';
import '../../entity/user/user.entity.dart';

@Singleton(as: UserRepository)
class UserRepositoryImpl extends UserRepository {
  final RemoteUserDataSource _userDataSource;

  UserRepositoryImpl(RemoteUserDataSource userDataSource)
      : _userDataSource = userDataSource;

  @override
  Future<Either<Failure, DateTime>> updateLastSeenAt() async {
    try {
      return await _userDataSource.updateLastSeenAt().then((dt) => right(dt));
    } on CustomException catch (err) {
      return left(Failure(code: err.code, message: err.message));
    }
  }

  @override
  Future<Either<Failure, List<UserEntity>>> searchUserByHashtag(
      {required String hashtag, int skip = 0, int take = 100}) async {
    try {
      final fetched = await _userDataSource.searchUserByHashtag(
          hashtag: hashtag, skip: skip, take: take);
      return right(fetched.map(UserEntity.fromModel).toList());
    } on CustomException catch (err) {
      return left(Failure(code: err.code, message: err.message));
    }
  }

  @override
  Future<Either<Failure, List<UserEntity>>> searchUserByNickname(
      {required String nickname,
      bool exact = true,
      int skip = 0,
      int take = 100}) async {
    try {
      final fetched = await _userDataSource.searchUserByNickname(
          nickname: nickname, skip: skip, take: take);
      return right(fetched.map(UserEntity.fromModel).toList());
    } on CustomException catch (err) {
      return left(Failure(code: err.code, message: err.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> findUserById(String uid) async {
    try {
      final user = await _userDataSource.findUserById(uid);
      return right(UserEntity.fromModel(user));
    } on CustomException catch (err) {
      return left(Failure(code: err.code, message: err.message));
    }
  }

  @override
  Future<Either<Failure, void>> modifyUser(UserEntity user) async {
    try {
      await _userDataSource.modifyUser(UserModel.fromEntity(user));
      return right(null);
    } on CustomException catch (err) {
      return left(Failure(code: err.code, message: err.message));
    }
  }

  @override
  Future<Either<Failure, String>> upsertProfileImageAndReturnDownloadLink(
      File image) async {
    try {
      final downloadLink =
          await _userDataSource.upsertProfileImageAndReturnDownloadLink(image);
      return right(downloadLink);
    } on CustomException catch (err) {
      return left(Failure(code: err.code, message: err.message));
    }
  }
}
