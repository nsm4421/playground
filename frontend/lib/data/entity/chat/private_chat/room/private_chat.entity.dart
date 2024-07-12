import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hot_place/data/entity/user/user.entity.dart';

import '../../../../../domain/model/chat/private_chat/room/private_chat.model.dart';

part 'private_chat.entity.freezed.dart';

@freezed
class PrivateChatEntity with _$PrivateChatEntity {
  const factory PrivateChatEntity(
      {String? id, // 채팅방 id
      UserEntity? currentUser, // 로그인 유저
      UserEntity? opponent, // 대화 상대방
      String? lastMessage, // 최근 메세지
      @Default(0) int unReadCount, // 읽지 않은 메세지 개수
      DateTime? createdAt,
      DateTime? updatedAt}) = _PrivateChatEntity;

  factory PrivateChatEntity.fromModel(PrivateChatModel model) =>
      PrivateChatEntity(
          id: model.id,
          currentUser: UserEntity(
              id: model.user_id,
              nickname: model.nickname,
              profileImage: model.profile_image),
          opponent: UserEntity(
              id: model.opponent_id,
              nickname: model.opponent_nickname,
              profileImage: model.opponent_profile_image),
          lastMessage: model.last_message ?? '',
          unReadCount: model.un_read_count ?? 0,
          createdAt: model.created_at,
          updatedAt: model.updated_at);
}
