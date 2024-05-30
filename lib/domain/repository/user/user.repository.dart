import 'package:fpdart/fpdart.dart';
import 'package:my_app/core/exception/failure.dart';
import 'package:my_app/data/entity/user/user.entity.dart';

abstract interface class UserRepository {
  Future<Either<Failure, UserEntity>> getCurrentUser();

  Future<Either<Failure, void>> upsertUser(UserEntity entity);

  Future<Either<Failure, void>> deleteUser();
}
