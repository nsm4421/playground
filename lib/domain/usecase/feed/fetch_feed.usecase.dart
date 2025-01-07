part of '../export.usecase.dart';

class FetchFeedUseCase {
  final FeedRepository _repository;

  FetchFeedUseCase(this._repository);

  Future<Either<ErrorResponse, SuccessResponse<Pageable<FeedEntity>>>> call(
      {required int page, int pageSize = 20, int? lastId}) async {
    return await _repository.fetch(
        page: page, pageSize: pageSize, lastId: lastId);
  }
}
