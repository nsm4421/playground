import 'package:travel/data/model/auth/auth_user.model.dart';

class PresenceEntity {
  final String uid;
  final String? email;
  final String username;
  final String avatarUrl;

  PresenceEntity(
      {required this.uid,
      this.email,
      required this.username,
      required this.avatarUrl});

  static PresenceEntity? from(AuthUserModel? user) {
    return user == null
        ? null
        : PresenceEntity(
            uid: user.id,
            email: user.email,
            username: user.username,
            avatarUrl: user.avatar_url);
  }
}
