part of '../../../module/user/account.usecase.dart';

class UpsertProfileImageUseCase {
  final AccountRepository _repository;

  UpsertProfileImageUseCase(this._repository);

  Future<Either<Failure, String>> call(File image) async {
    try {
      // Storage에 이미지 저장
      await _repository
          .saveProfileImage(image)
          .then((res) => res.getOrElse((l) {
                throw l.toCustomException();
              }));

      // 프로필 이미지 다운로드 링크 Return
      return right(_repository.profileImageUrl);
    } on CustomException catch (error) {
      return left(Failure(code: error.code, message: error.message));
    }
  }
}
