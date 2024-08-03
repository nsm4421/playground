part of "../feed.usecase_module.dart";

class CreateFeedUseCase {
  final FeedRepository _repository;

  CreateFeedUseCase(this._repository);

  Future<ResponseWrapper<void>> call({
    required String feedId,
    required String content,
    required List<String> hashtags,
    required List<File> files,
  }) async {
    Iterable<String> media = [];
    if (files.isNotEmpty) {
      final uploadMediaRes =
          await _repository.uploadMedia(feedId: feedId, files: files);
      if (!uploadMediaRes.ok) {
        return ResponseWrapper.error(uploadMediaRes.message);
      }
      media = uploadMediaRes.data!;
    }
    // 피드 정보 업로드
    return await _repository.createFeed(FeedEntity(
        id: feedId,
        content: content,
        media: media.toList(),
        hashtags: hashtags));
  }
}
