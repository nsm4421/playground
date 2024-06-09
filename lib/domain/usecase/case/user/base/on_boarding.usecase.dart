part of '../../../module/user/account.usecase.dart';

class OnBoardingUseCase {
  final AccountRepository _repository;

  OnBoardingUseCase(this._repository);

  Future<Either<Failure, AccountEntity>> call({
    required User sessionUser,
    required String nickname,
    required File image,
    required String description,
  }) async {
    try {
      // Storage에 이미지 저장
      final profileUrl = await _repository.saveProfileImage(image).then((res) =>
          res.fold(
              (l) => throw l.toCustomException(message: '프로필 이미지 저장 중 오류 발생'),
              (r) => _repository.profileImageUrl));

      // DB에 유저정보 저장
      final account = AccountEntity(
          id: sessionUser.id,
          nickname: nickname,
          profileUrl: profileUrl,
          description: description);
      await _repository.upsertUser(account).then((res) => res.fold(
          (l) => throw l.toCustomException(message: '유저 정보 저장중 오류가 발생했습니다'),
          (r) => r));
      return right(account);
    } on CustomException catch (error) {
      return left(Failure(code: error.code, message: error.message));
    }
  }
}
