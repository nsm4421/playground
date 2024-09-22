part of '../usecase.dart';

class EditFeedUseCase {
  final FeedRepository _repository;

  EditFeedUseCase(this._repository);

  Future<UseCaseResponseWrapper<void>> call(
      {required String feedId,
      File? feedImage,
      String? caption,
      List<String>? hashtags}) async {
    String? media;
    if (feedImage != null) {
      final feedImageUploadRes =
          await _repository.uploadFeedImage(feedImage, upsert: true);
      if (!feedImageUploadRes.ok) {
        return UseCaseError.from(message: '피드 사진 업로드 중 오류가 발생했습니다');
      }
      media = (feedImageUploadRes as RepositorySuccess).data;
    }
    return await _repository
        .editFeed(
            feedId: feedId, media: media, caption: caption, hashtags: hashtags)
        .then(UseCaseResponseWrapper.from);
  }
}
