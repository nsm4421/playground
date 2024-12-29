part of '../export.usecase.dart';

class DeleteFeedUseCase {
  final FeedRepository _repository;

  DeleteFeedUseCase(this._repository);

  Future<Either<ErrorResponse, SuccessResponse<void>>> call(
      {required int id}) async {
    return await _repository.deleteFeed(id);
  }
}
