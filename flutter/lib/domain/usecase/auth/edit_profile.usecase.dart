part of '../export.usecase.dart';

class EditProfileUseCase {
  final AuthRepository _repository;

  EditProfileUseCase(this._repository);

  Future<Either<ErrorResponse, SuccessResponse<void>>> call(
      {required String nickname, File? profileImage}) async {
    return await _repository.editProfile(
        nickname: nickname, profileImage: profileImage);
  }
}
