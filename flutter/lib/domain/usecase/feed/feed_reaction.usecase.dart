part of '../export.usecase.dart';

class CountLikeOnFeedUseCase {
  final FeedReactionRepository _repository;

  CountLikeOnFeedUseCase(this._repository);

  Future<Either<ErrorResponse, SuccessResponse<int>>> call(int feedId) async {
    return await _repository.count(feedId);
  }
}

class LikeOnFeedUseCase {
  final FeedReactionRepository _repository;

  LikeOnFeedUseCase(this._repository);

  Future<Either<ErrorResponse, SuccessResponse<ReactionEntity>>> call(
      int feedId) async {
    return await _repository.create(feedId);
  }
}

class CancelLikeOnFeedUseCase {
  final FeedReactionRepository _repository;

  CancelLikeOnFeedUseCase(this._repository);

  Future<Either<ErrorResponse, SuccessResponse<void>>> call(int feedId) async {
    return await _repository.delete(feedId);
  }
}
