part of '../export.usecase.dart';

class DeleteFeedUseCase {
  final FeedRepository _repository;

  DeleteFeedUseCase(this._repository);

  Future<Either<ErrorResponse, SuccessResponse<void>>> call(int id) async {
    return await _repository.delete(id);
  }
}
