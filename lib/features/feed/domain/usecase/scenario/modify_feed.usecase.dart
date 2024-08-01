part of "../feed.usecase_module.dart";

class ModifyFeedUseCase {
  final FeedRepository _repository;

  ModifyFeedUseCase(this._repository);

  Future<ResponseWrapper<void>> call(
      {required String feedId,
      String? content,
      List<File>? files,
      List<String>? hashtags}) async {
    // 파일 업로드
    Iterable<String>? media;
    if (files != null) {
      final uploadMediaRes =
          await _repository.uploadMedia(feedId: feedId, files: files);
      if (!uploadMediaRes.ok) {
        return ResponseWrapper.error(uploadMediaRes.message);
      }
      media = uploadMediaRes.data;
    }
    // 피드 정보 업로드
    return await _repository.modifyFeed(
        feedId: feedId,
        content: content,
        media: media?.toList(),
        hashtags: hashtags);
  }
}
