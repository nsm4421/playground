part of '../usecase.dart';

class EditFeedUseCase {
  final FeedRepository _repository;

  EditFeedUseCase(this._repository);

  Future<ResponseWrapper<void>> call(
      {required String feedId,
      File? feedImage,
      String? caption,
      List<String>? hashtags}) async {
    String? media;
    if (feedImage != null) {
      final feedImageUploadRes =
          await _repository.uploadFeedImage(feedImage, upsert: true);
      if (!feedImageUploadRes.ok) {
        return const ErrorResponse(message: '피드 수정 이미지 업로드 중 오류 발생');
      }
      media = feedImageUploadRes.data!;
    }
    return await _repository
        .editFeed(
            feedId: feedId, media: media, caption: caption, hashtags: hashtags)
        .then((res) =>
            res.copyWith(message: res.ok ? '피드 수정하기 성공' : '피드 수정하기 실패'));
  }
}
