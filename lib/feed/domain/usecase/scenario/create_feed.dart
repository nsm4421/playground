part of '../usecase.dart';

class CreateFeedUseCase {
  final FeedRepository _repository;

  CreateFeedUseCase(this._repository);

  Future<UseCaseResponseWrapper<void>> call(
      {required String feedId,
      required File feedImage,
      required String caption}) async {
    final feedImageUploadRes = await _repository.uploadFeedImage(feedImage);
    if (!feedImageUploadRes.ok) {
      return UseCaseError.from(feedImageUploadRes,
          message: '피드 사진 업로드 중 오류가 발생했습니다');
    }
    final media = (feedImageUploadRes as RepositorySuccess).data;
    return await _repository
        .createFeed(feedId: feedId, media: media, caption: caption)
        .then(UseCaseResponseWrapper.from);
  }
}
