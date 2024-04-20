import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hot_place/data/entity/chat/private_chat/room/private_chat.entity.dart';
import 'package:hot_place/domain/model/user/user.model.dart';

import '../../../../../core/util/uuid.util.dart';

part 'private_chat.model.freezed.dart';

part 'private_chat.model.g.dart';

@freezed
class PrivateChatModel with _$PrivateChatModel {
  const factory PrivateChatModel(
      {@Default('') String id,
      // 현재 로그인 유저
      @Default('') user_id,
      @Default('') nickname,
      @Default('') profile_image,
      // 대화 상대방
      @Default('') opponent_id,
      @Default('') opponent_nickname,
      @Default('') opponent_profile_image,
      @Default('') last_message, // 최근 메세지
      @Default(0) int un_read_count, // 읽지 않은 메세지 개수
      DateTime? updated_at, // 최근 메세지 전송시간
      DateTime? created_at}) = _PrivateChatModel;

  factory PrivateChatModel.fromJson(Map<String, dynamic> json) =>
      _$PrivateChatModelFromJson(json);

  factory PrivateChatModel.newFromUsers(
          {required UserModel currentUser, required UserModel opponentUser}) =>
      PrivateChatModel(
          id: UuidUtil.uuid(),
          user_id: currentUser.id,
          nickname: currentUser.nickname,
          profile_image: currentUser.nickname,
          opponent_id: opponentUser.id,
          opponent_nickname: opponentUser.nickname,
          opponent_profile_image: opponentUser.profile_image,
          created_at: DateTime.now(),
          updated_at: DateTime.now());

  factory PrivateChatModel.fromEntity(PrivateChatEntity entity) =>
      PrivateChatModel(
          id: entity.id ?? '',
          user_id: entity.currentUser?.id ?? '',
          nickname: entity.currentUser?.nickname ?? '',
          profile_image: entity.currentUser?.profileImage ?? '',
          opponent_id: entity.opponent?.id ?? '',
          opponent_nickname: entity.opponent?.nickname ?? '',
          opponent_profile_image: entity.opponent?.profileImage ?? '',
          last_message: entity.lastMessage ?? '',
          un_read_count: entity.unReadCount ?? 0,
          updated_at: entity.updatedAt,
          created_at: entity.createdAt);
}

extension PrivateChatModelEx on PrivateChatModel {
  PrivateChatModel swap({String? chatId}) => copyWith(
        id: chatId ?? UuidUtil.uuid(),
        user_id: opponent_id,
        nickname: opponent_nickname,
        profile_image: opponent_profile_image,
        opponent_id: user_id,
        opponent_nickname: nickname,
        opponent_profile_image: profile_image,
      );
}
