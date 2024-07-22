part of "auth.usecase_module.dart";

class SignUpWithEmailAndPasswordUseCase {
  final AuthRepository _repository;

  SignUpWithEmailAndPasswordUseCase(this._repository);

  Future<ResponseWrapper<User>> call(
      {required String email,
      required String password,
      required File profileImage}) async {
    // 회원가입 처리
    final signUpRes =
        await _repository.signUpWithEmailAndPassword(email, password);
    User? user = signUpRes.data;
    if (!signUpRes.ok || user == null) {
      return ResponseWrapper.error(signUpRes.message ?? 'sign up fail');
    }

    // 프로필 이미지 저장
    final storeRes = await _repository.upsertProfileImage(
        uid: user.id, profileImage: profileImage);
    final publicUrl = storeRes.data;
    if (!storeRes.ok || publicUrl == null) {
      return ResponseWrapper.error(storeRes.message ?? 'sign up fail');
    }

    // 메타데이터 업로드
    final metaRes = await _repository.updateMetaData(
        nickname: email, profileImage: publicUrl);
    if (!metaRes.ok || metaRes.data != null) {
      user = metaRes.data;
    }

    // 회원정보 저장
    final insertRes =
        await _repository.insertAccount(AccountEntity.fromUser(user!));
    if (!insertRes.ok) {
      return ResponseWrapper.error(insertRes.message ?? 'save account fail');
    }
    return ResponseWrapper.success(user);
  }
}
