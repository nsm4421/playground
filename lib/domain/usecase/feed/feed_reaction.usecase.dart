part of '../export.usecase.dart';

class CountLikeOnFeedUseCase {
  final ReactionRepository _repository;

  CountLikeOnFeedUseCase(this._repository);

  Future<Either<ErrorResponse, SuccessResponse<int>>> call(int id) async {
    return await _repository.count(id: id, ref: ReactionReference.feeds);
  }
}

class LikeOnFeedUseCase {
  final ReactionRepository _repository;

  LikeOnFeedUseCase(this._repository);

  Future<Either<ErrorResponse, SuccessResponse<ReactionEntity>>> call(int id) async {
    return await _repository.create(id: id, ref: ReactionReference.feeds);
  }
}

class CancelLikeOnFeedUseCase {
  final ReactionRepository _repository;

  CancelLikeOnFeedUseCase(this._repository);

  Future<Either<ErrorResponse, SuccessResponse<void>>> call(int id) async {
    return await _repository.delete(id: id, ref: ReactionReference.feeds);
  }
}
