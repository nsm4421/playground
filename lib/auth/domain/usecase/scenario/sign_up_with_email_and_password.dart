part of '../usecase.dart';

class SignUpWithEmailAndPasswordUseCase {
  final AuthRepository _repository;

  SignUpWithEmailAndPasswordUseCase(this._repository);

  Future<User?> call({
    required String email,
    required String password,
    required String username,
    required File profileImage,
  }) async {
    // 프로필 이미지 업로드
    final avatarUrl = await _repository.uploadProfileImage(profileImage);

    // 회원가입
    return await _repository.signUpWithEmailAndPassword(
        email: email,
        password: password,
        username: username,
        avatarUrl: avatarUrl);
  }
}
