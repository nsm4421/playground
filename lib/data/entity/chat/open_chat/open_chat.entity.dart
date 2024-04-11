import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hot_place/data/entity/user/user.entity.dart';
import 'package:hot_place/domain/model/chat/open_chat/open_chat.model.dart';
import 'package:hot_place/domain/model/chat/open_chat/open_chat_with_user.model.dart';

import '../../../../domain/model/user/user.model.dart';

part 'open_chat.entity.freezed.dart';

part 'open_chat.entity.g.dart';

@freezed
class OpenChatEntity with _$OpenChatEntity {
  const factory OpenChatEntity({
    String? id,
    UserEntity? host,
    String? title,
    @Default(<String>[]) List<String> hashtags,
    DateTime? createdAt,
  }) = _OpenChatEntity;

  factory OpenChatEntity.fromJson(Map<String, dynamic> json) =>
      _$OpenChatEntityFromJson(json);

  factory OpenChatEntity.fromModel(OpenChatModel openChat, {UserModel? host}) =>
      OpenChatEntity(
        id: openChat.id.isNotEmpty ? openChat.id : null,
        host: host != null
            ? UserEntity.fromModel(host)
            : UserEntity(id: openChat.host_id),
        title: openChat.title.isNotEmpty ? openChat.title : null,
        hashtags: openChat.hashtags.isNotEmpty ? openChat.hashtags : [],
      );

  factory OpenChatEntity.fromModelWithUser(OpenChatWithUserModel openChat) =>
      OpenChatEntity(
        id: openChat.id.isNotEmpty ? openChat.id : null,
        host: UserEntity.fromModel(openChat.host),
        title: openChat.title.isNotEmpty ? openChat.title : null,
        hashtags: openChat.hashtags.isNotEmpty ? openChat.hashtags : [],
      );
}
