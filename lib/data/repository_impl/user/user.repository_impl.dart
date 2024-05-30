import 'package:fpdart/src/either.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/core/exception/custom_exeption.dart';
import 'package:my_app/core/exception/failure.dart';
import 'package:my_app/data/datasource/user/user.datasource.dart';
import 'package:my_app/data/entity/user/user.entity.dart';
import 'package:my_app/domain/model/user/user.model.dart';
import 'package:my_app/domain/repository/user/user.repository.dart';

@Singleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final RemoteUserDataSource _remoteDataSource;

  UserRepositoryImpl({required RemoteUserDataSource remoteUserDataSource})
      : _remoteDataSource = remoteUserDataSource;

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    try {
      return await _remoteDataSource
          .getCurrentUser()
          .then((model) => UserEntity.fromModel(model))
          .then((entity) => right(entity));
    } on CustomException catch (error) {
      return left(Failure(code: error.code, message: error.message));
    }
  }

  @override
  Future<Either<Failure, void>> upsertUser(UserEntity entity) async {
    try {
      return await _remoteDataSource
          .upsertUser(UserModel.fronEntity(entity))
          .then((_) => right(null));
    } on CustomException catch (error) {
      return left(Failure(code: error.code, message: error.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteUser() async {
    try {
      return await _remoteDataSource
          .deleteUser()
          .then((_) => right(null));
    } on CustomException catch (error) {
      return left(Failure(code: error.code, message: error.message));
    }
  }
}
