part of '../../module/user/user.usecase.dart';

class UpsertUserUseCase {
  final UserRepository _repository;

  UpsertUserUseCase(this._repository);

  Future<Either<Failure, void>> call(UserEntity entity) async {
    return await _repository.upsertUser(entity);
  }
}
