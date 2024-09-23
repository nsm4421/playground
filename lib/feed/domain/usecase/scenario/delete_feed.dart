part of '../usecase.dart';

class DeleteFeedUseCase {
  final FeedRepository _repository;

  DeleteFeedUseCase(this._repository);

  Future<ResponseWrapper<void>> call(
    String feedId,
  ) async {
    return await _repository.deleteFeedById(feedId).then(
        (res) => res.copyWith(message: res.ok ? '피드 삭제하기 성공' : '피드 삭제하기 실패'));
  }
}
