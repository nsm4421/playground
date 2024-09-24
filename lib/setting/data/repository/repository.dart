part of 'repository_impl.dart';

abstract class AccountRepository {
  Future<ResponseWrapper<void>> checkUsername(String username);

  Future<ResponseWrapper<void>> updateAccount(
      {String? username, String? avatarUrl});

  Future<ResponseWrapper<String>> editProfileImage(File profileImage);
}
