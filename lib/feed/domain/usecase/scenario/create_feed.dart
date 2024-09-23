part of '../usecase.dart';

class CreateFeedUseCase {
  final FeedRepository _repository;

  CreateFeedUseCase(this._repository);

  Future<ResponseWrapper<void>> call({
    required String feedId,
    required File feedImage,
    required String caption,
    required List<String> hashtags,
  }) async {
    final feedImageUploadRes = await _repository.uploadFeedImage(feedImage);
    if (!feedImageUploadRes.ok) {
      return const ErrorResponse(message: '피드 사진 업로드 중 오류가 발생했습니다');
    }
    final media = feedImageUploadRes.data!;
    return await _repository
        .createFeed(
            feedId: feedId, media: media, caption: caption, hashtags: hashtags)
        .then((res) =>
            res.copyWith(message: res.ok ? '피드 작성하기 성공' : '피드 작성하기 실패'));
  }
}
