import 'dart:io';

import '../../../domain/model/user/user.model.dart';

abstract interface class RemoteUserDataSource {
  Future<Iterable<UserModel>> searchUserByNickname({
    required String nickname,
    bool exact = true,
    int skip = 0,
    int take = 100,
  });

  Future<Iterable<UserModel>> searchUserByHashtag({
    required String hashtag,
    int skip = 0,
    int take = 100,
  });

  Future<UserModel> findUserById(String uid);

  Future<void> modifyUser(UserModel user);

  Future<String> upsertProfileImageAndReturnDownloadLink(File image);

  Future<DateTime> updateLastSeenAt();
}
