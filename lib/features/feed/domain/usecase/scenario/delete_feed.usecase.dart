part of "../feed.usecase_module.dart";

class DeleteFeedUseCase {
  final FeedRepository _repository;

  DeleteFeedUseCase(this._repository);

  Future<ResponseWrapper<void>> call(String feedId) async {
    return await _repository.deleteFeedById(feedId);
  }
}
