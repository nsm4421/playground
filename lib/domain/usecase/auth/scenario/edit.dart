part of '../usecase.dart';

class EditProfileUseCase {
  final AuthRepository _repository;

  EditProfileUseCase(this._repository);

  Future<Either<ErrorResponse, PresenceEntity?>> call(
      {String? username, File? profileImage}) async {
    return await _repository
        .editProfile(username: username, profileImage: profileImage)
        .mapLeft((l) => l.copyWith(
                message: switch (l.type) {
              ErrorType.auth => 'error occurs update profile',
              ErrorType.storage => 'error occurs on uploading profile image',
              ErrorType.db => 'it seems username is duplicated',
              (_) => 'unknown error'
            }));
  }
}
