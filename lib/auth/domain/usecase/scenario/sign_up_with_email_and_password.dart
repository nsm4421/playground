part of '../usecase.dart';

class SignUpWithEmailAndPasswordUseCase {
  final AuthRepository _repository;

  SignUpWithEmailAndPasswordUseCase(this._repository);

  Future<ResponseWrapper<User?>> call({
    required String email,
    required String password,
    required String username,
    required File profileImage,
  }) async {
    // 프로필 이미지 업로드
    final profileUploadRes = await _repository.uploadProfileImage(profileImage);
    if (!profileUploadRes.ok) {
      return const ErrorResponse<User?>(message: '프로필 사진 업로드 중 오류가 발생했습니다');
    }
    final avatarUrl = profileUploadRes.data!;
    // 회원가입
    final signUpRes = await _repository.signUpWithEmailAndPassword(
        email: email,
        password: password,
        username: username,
        avatarUrl: avatarUrl);
    return signUpRes.ok
        ? SuccessResponse<User?>(
            data: signUpRes.data!, message: '$username님 회원가입에 성공하였습니다')
        : const ErrorResponse<User?>(message: '회원가입에 실패하였습니다');
  }
}
