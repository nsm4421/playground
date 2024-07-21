part of "auth.usecase_module.dart";

/// 인증 스트림 가져오기
class GetAuthStreamUseCase {
  final AuthRepository _repository;

  GetAuthStreamUseCase(this._repository);

  Stream<AuthState> call() => _repository.authStream;
}

/// 현재 인증정보 가져오기
class GetCurrentUserUseCase {
  final AuthRepository _repository;

  GetCurrentUserUseCase(this._repository);

  User? call() => _repository.currentUser;
}

/// 회원가입
class SignUpWithEmailAndPasswordUseCase {
  final AuthRepository _repository;

  SignUpWithEmailAndPasswordUseCase(this._repository);

  Future<ResponseWrapper<User>> call(String email, String password) async {
    // 회원가입 처리
    final signUpRes =
        await _repository.signUpWithEmailAndPassword(email, password);
    final user = signUpRes.data;
    if (!signUpRes.ok || user == null) {
      return ResponseWrapper.error('sign up fail');
    }
    // 회원정보 저장
    final insertRes =
        await _repository.insertAccount(AccountEntity.fromUser(user));
    if (insertRes.ok) {
      return ResponseWrapper.error('save account fail');
    }
    return ResponseWrapper.success(user);
  }
}

/// 로그인
class SignInWithEmailAndPasswordUseCase {
  final AuthRepository _repository;

  SignInWithEmailAndPasswordUseCase(this._repository);

  Future<ResponseWrapper<User>> call(String email, String password) async =>
      await _repository.signInWithEmailAndPassword(email, password);
}

/// 프로필 수정
class EditProfileUseCase {
  final AuthRepository _repository;

  EditProfileUseCase(this._repository);

  Future<ResponseWrapper<User>> call(
      {required String uid, String? nickname, String? profileImage}) async {
    // 메타정보 업데이트
    final metaDataRes = await _repository.updateMetaData(
        nickname: nickname, profileImage: profileImage);
    final user = metaDataRes.data;
    if (!metaDataRes.ok || user == null) {
      return ResponseWrapper.error('update meta data fail');
    }
    // 유저정보 업데이트
    final updateRes = await _repository.updateAccount(
        uid: uid, nickname: nickname, profileImage: profileImage);
    if (!updateRes.ok) {
      return ResponseWrapper.error('update account table fail');
    }
    return ResponseWrapper.success(user);
  }
}

/// 로그아웃
class SignOutUseCase {
  final AuthRepository _repository;

  SignOutUseCase(this._repository);

  Future<ResponseWrapper<void>> call() async => await _repository.signOut();
}
