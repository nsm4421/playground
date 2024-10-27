part of '../usecase.dart';

class CreateLikeUseCase {
  final LikeRepository _repository;
  final BaseEntity _ref;

  CreateLikeUseCase(this._repository, {required BaseEntity ref}) : _ref = ref;

  Future<Either<ErrorResponse, void>> call() async {
    return await _repository.create(_ref).then((res) =>
        res.mapLeft((l) => l.copyWith(message: 'fail to create like')));
  }
}

class CancelLikeUseCase {
  final LikeRepository _repository;
  final BaseEntity _ref;

  CancelLikeUseCase(this._repository, {required BaseEntity ref}) : _ref = ref;

  Future<Either<ErrorResponse, void>> call() async {
    return await _repository.delete(_ref).then((res) =>
        res.mapLeft((l) => l.copyWith(message: 'fail to delete like')));
  }
}
