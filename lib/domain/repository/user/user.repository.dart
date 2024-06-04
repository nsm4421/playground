part of 'package:my_app/data/repository_impl/user/user.repository_impl.dart';

abstract interface class UserRepository {
  Future<Either<Failure, UserEntity>> getCurrentUser();

  Future<Either<Failure, void>> upsertUser(UserEntity entity);

  Future<Either<Failure, void>> deleteUser();

  Future<Either<Failure, bool>> checkIsDuplicatedNickname(String nickname);

  Future<Either<Failure, String>> getProfileImageDownloadUrl();

  Future<Either<Failure, void>> saveProfileImage(File image);
}
