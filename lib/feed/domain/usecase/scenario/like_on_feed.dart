part of '../usecase.dart';

class SendLikeOnFeedUseCase {
  final FeedRepository _repository;

  SendLikeOnFeedUseCase(this._repository);

  Future<ResponseWrapper<String>> call(String feedId) async {
    return await _repository.saveLike(feedId).then((res) =>
        res.copyWith(message: res.ok ? '좋아요 취소 요청 성공' : '좋아요 취소 요청 실패'));
  }
}

class CancelLikeOnFeedUseCase {
  final FeedRepository _repository;

  CancelLikeOnFeedUseCase(this._repository);

  Future<ResponseWrapper<void>> call(String feedId) async {
    return await _repository.deleteLike(feedId).then((res) =>
        res.copyWith(message: res.ok ? '좋아요 취소 요청 성공' : '좋아요 취소 요청 실패'));
  }
}
