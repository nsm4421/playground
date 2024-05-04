import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:hot_place/data/entity/user/user.entity.dart';

import '../../../core/error/failure.constant.dart';

abstract class UserRepository {
  Future<Either<Failure, DateTime>> updateLastSeenAt();

  Future<Either<Failure, List<UserEntity>>> searchUserByNickname(
      {required String nickname,
      bool exact = true,
      int skip = 0,
      int take = 100});

  Future<Either<Failure, List<UserEntity>>> searchUserByHashtag(
      {required String hashtag, int skip = 0, int take = 100});

  Future<Either<Failure, UserEntity>> findUserById(String uid);

  Future<Either<Failure, void>> modifyUser(UserEntity user);

  Future<Either<Failure, String>> upsertProfileImageAndReturnDownloadLink(
      File image);
}
