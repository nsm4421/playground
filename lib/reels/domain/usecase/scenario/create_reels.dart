part of '../usecase.dart';

class CreateReelsUseCase {
  final ReelsRepository _repository;

  CreateReelsUseCase(this._repository);

  Future<UseCaseResponseWrapper<void>> call(
      {required String reelsId,
      required File video,
      required String caption}) async {
    final feedImageUploadRes = await _repository.uploadReelsVideo(video);
    if (!feedImageUploadRes.ok) {
      return UseCaseError.from(feedImageUploadRes,
          message: '릴스 업로드 중 오류가 발생했습니다');
    }
    final media = (feedImageUploadRes as RepositorySuccess).data;
    return await _repository
        .createReels(reelsId: reelsId, media: media, caption: caption)
        .then(UseCaseResponseWrapper.from);
  }
}
