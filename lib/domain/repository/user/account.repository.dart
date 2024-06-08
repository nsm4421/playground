part of 'package:my_app/data/repository_impl/user/account.repository_impl.dart';

abstract interface class AccountRepository {
  Future<Either<Failure, AccountEntity>> getCurrentUser();

  Future<Either<Failure, void>> upsertUser(AccountEntity entity);

  Future<Either<Failure, void>> deleteUser();

  Future<Either<Failure, bool>> checkIsDuplicatedNickname(String nickname);

  Future<Either<Failure, String>> getProfileImageDownloadUrl();

  Future<Either<Failure, void>> saveProfileImage(File image);
}
