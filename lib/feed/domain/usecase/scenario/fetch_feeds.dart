part of '../usecase.dart';

class FetchFeedsUseCase {
  final FeedRepository _repository;

  FetchFeedsUseCase(this._repository);

  Future<ResponseWrapper<List<FeedEntity>>> call(
      {DateTime? beforeAt, int take = 20}) async {
    return await _repository
        .fetchFeeds(beforeAt: (beforeAt ?? DateTime.now().toUtc()), take: take)
        .then((res) =>
            res.copyWith(message: res.ok ? '피드 가져오기 성공' : '피드 가져오기 실패'));
  }
}
