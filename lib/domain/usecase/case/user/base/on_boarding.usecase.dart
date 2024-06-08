part of '../../../module/user/user.usecase.dart';

class OnBoardingUseCase {
  final AccountRepository _repository;

  OnBoardingUseCase(this._repository);

  Future<Either<Failure, AccountEntity>> call({
    required User sessionUser,
    required String nickname,
    required File image, // 프로필 이미지
    required String description,
  }) async {
    try {
      // 닉네임 중복검사
      await _repository
          .checkIsDuplicatedNickname(nickname)
          .then((res) => res.fold((l) {
                throw l.toCustomException();
              }, (r) {
                if (r) {
                  throw CustomException(
                      errorCode: ErrorCode.firebaseAlreadyExists,
                      message: '중복된 닉네임입니다');
                }
              }));

      // Storage에 이미지 저장
      await _repository
          .saveProfileImage(image)
          .then((res) => res.getOrElse((l) {
                throw l.toCustomException();
              }));

      // 프로필 이미지 다운로드 링크
      final profileUrl = await _repository
          .getProfileImageDownloadUrl()
          .then((res) => res.getOrElse((l) {
                throw l.toCustomException();
              }));

      // DB에 유저정보 저장
      await _repository.upsertUser(AccountEntity(
          nickname: nickname,
          profileUrl: profileUrl,
          description: description));

      // 유저정보 반환
      return right(AccountEntity(
          id: sessionUser.id,
          nickname: nickname,
          profileUrl: profileUrl,
          description: description));
    } on CustomException catch (error) {
      return left(Failure(code: error.code, message: error.message));
    }
  }
}
