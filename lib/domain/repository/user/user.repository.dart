import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:hot_place/data/entity/user/user.entity.dart';

import '../../../core/error/failure.constant.dart';

abstract class UserRepository {
  Future<Either<Failure, UserEntity>> findUserById(String uid);

  Future<Either<Failure, void>> modifyUser(UserEntity user);

  Future<Either<Failure, String>> upsertProfileImageAndReturnDownloadLink(
      File image);
}
