import 'dart:io';

import '../../../domain/model/user/user.model.dart';

abstract interface class UserDataSource {
  Future<UserModel> findUserById(String uid);

  Future<void> modifyUser(UserModel user);

  Future<String> upsertProfileImageAndReturnDownloadLink(File image);
}
