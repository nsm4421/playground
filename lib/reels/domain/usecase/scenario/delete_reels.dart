part of '../usecase.dart';

class DeleteReelsUseCase {
  final ReelsRepository _repository;

  DeleteReelsUseCase(this._repository);

  Future<UseCaseResponseWrapper<void>> call(
    String reelsId,
  ) async {
    return await _repository
        .deleteReelsById(reelsId)
        .then(UseCaseResponseWrapper.from);
  }
}
