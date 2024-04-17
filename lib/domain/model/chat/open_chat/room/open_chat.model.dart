import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hot_place/data/entity/chat/open_chat/room/open_chat.entity.dart';

part 'open_chat.model.freezed.dart';

part 'open_chat.model.g.dart';

@freezed
class OpenChatModel with _$OpenChatModel {
  const factory OpenChatModel({
    @Default('') String id,
    @Default('') String user_id,
    @Default('') String nickname,
    String? profile_image,
    @Default('') String title,
    @Default(<String>[]) List<String> hashtags,
    DateTime? created_at,
  }) = _OpenChatModel;

  factory OpenChatModel.fromJson(Map<String, dynamic> json) =>
      _$OpenChatModelFromJson(json);

  factory OpenChatModel.fromEntity(OpenChatEntity openChat) => OpenChatModel(
        id: openChat.id ?? '',
        user_id: openChat.host?.id ?? '',
        nickname: openChat.host?.nickname ?? '',
        profile_image: openChat.host?.profileImage,
        title: openChat.title ?? '',
        hashtags: openChat.hashtags,
        created_at: openChat.createdAt,
      );
}
