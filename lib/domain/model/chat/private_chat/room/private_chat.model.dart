import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hot_place/data/entity/chat/private_chat/room/private_chat.entity.dart';

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
      DateTime? created_at // 메세지 전송시간
      }) = _PrivateChatModel;

  factory PrivateChatModel.fromJson(Map<String, dynamic> json) =>
      _$PrivateChatModelFromJson(json);

  factory PrivateChatModel.fromEntity(PrivateChatEntity entity) =>
      PrivateChatModel(
          id: entity.id ?? '',
          user_id: entity.currentUser?.id ?? '',
          nickname: entity.currentUser?.nickname ?? '',
          profile_image: entity.currentUser?.profileImage ?? '',
          opponent_id: entity.opponent?.id ?? '',
          opponent_nickname: entity.opponent?.nickname ?? '',
          opponent_profile_image: entity.opponent?.profileImage ?? '',
          last_message: entity.lateMessage ?? '',
          un_read_count: entity.unReadCount ?? 0,
          created_at: entity.createdAt);
}
