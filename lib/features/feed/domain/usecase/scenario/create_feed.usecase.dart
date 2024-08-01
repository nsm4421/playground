part of "../feed.usecase_module.dart";

class CreateFeedUseCase {
  final FeedRepository _repository;

  CreateFeedUseCase(this._repository);

  Future<ResponseWrapper<void>> call(FeedEntity entity) async {
    return await _repository.createFeed(entity);
  }
}
