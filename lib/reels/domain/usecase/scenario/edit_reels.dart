part of '../usecase.dart';

class EditReelsUseCase {
  final ReelsRepository _repository;

  EditReelsUseCase(this._repository);

  Future<UseCaseResponseWrapper<void>> call(
      {required String reelsId, File? video, String? caption}) async {
    String? media;
    if (video != null) {
      final videoUploadRes =
          await _repository.uploadReelsVideo(video, upsert: true);
      if (!videoUploadRes.ok) {
        return UseCaseError.from(videoUploadRes,
            message: '릴스 업로드 중 오류가 발생했습니다');
      }
      media = (videoUploadRes as RepositorySuccess).data;
    }
    return await _repository
        .editReels(reelsId: reelsId, media: media, caption: caption)
        .then(UseCaseResponseWrapper.from);
  }
}
