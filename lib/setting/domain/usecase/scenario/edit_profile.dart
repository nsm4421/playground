part of '../usecase.dart';

class EditProfileUseCase {
  final AccountRepository _repository;

  EditProfileUseCase(this._repository);

  Future<ResponseWrapper<void>> call({String? username, File? image}) async {
    log('[EditProfileUseCase]프로필 수정요청');
    String? avatarUrl;
    try {
      if (image != null) {
        final uploadProfileImageRes = await _repository.editProfileImage(image);
        if (!uploadProfileImageRes.ok) {
          return const ErrorResponse(message: '프로필 이미지 수정중 오류가 발생');
        }
        avatarUrl = uploadProfileImageRes.data!;
      }
      return await _repository
          .updateAccount(username: username, avatarUrl: avatarUrl)
          .then((res) =>
              res.copyWith(message: res.ok ? '프로필 수정 성공' : '프로필 수정 실패'));
    } catch (error) {
      log(error.toString());
      return const ErrorResponse(message: '알 수 없는 오류가 발생');
    }
  }
}
