import 'package:travel/core/constant/constant.dart';

import '../../../core/abstract/abstract.dart';
import '../../../data/model/auth/auth_user.dart';

class PresenceEntity {
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String username;
  final String avatarUrl;

  PresenceEntity(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.username = '',
      this.avatarUrl = ''});

  static PresenceEntity? from(AuthUserModel? model) {
    return model == null
        ? null
        : PresenceEntity(
            id: model.id,
            username: model.username,
            avatarUrl: model.avatar_url,
          );
  }
}
