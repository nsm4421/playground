part of 'usecase.dart';

class EditProfileUseCase {
  final AuthRepository _repository;

  EditProfileUseCase(this._repository);

  Future<Either<ErrorResponse, PresenceEntity?>> call(
      {String? username, File? profileImage}) async {
    return await _repository.editProfile(
        username: username, profileImage: profileImage);
  }
}
