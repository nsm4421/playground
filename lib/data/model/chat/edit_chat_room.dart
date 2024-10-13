import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_chat_room.freezed.dart';

part 'edit_chat_room.g.dart';

/// 오픈 채팅방 정보(방제, 해시태그) 수정
@freezed
class EditOpenChatModel with _$EditOpenChatModel {
  const factory EditOpenChatModel({
    @Default('') String id,
    String? title,
    List<String>? hashtags,
  }) = _EditOpenChatModel;

  factory EditOpenChatModel.fromJson(Map<String, dynamic> json) =>
      _$EditOpenChatModelFromJson(json);
}

/// 오픈 채팅방 메타정보 수정
@freezed
class EditOpenChatMetaDataModel with _$EditOpenChatMetaDataModel {
  const factory EditOpenChatMetaDataModel({
    @Default('') String id,
    @Default('') last_message_content,
    @Default('') last_message_created_at,
  }) = _EditOpenChatMetaDataModel;

  factory EditOpenChatMetaDataModel.fromJson(Map<String, dynamic> json) =>
      _$EditOpenChatMetaDataModelFromJson(json);
}

/// DM 메타정보 수정
@freezed
class EditPrivateChatMetaDataModel with _$EditPrivateChatMetaDataModel {
  const factory EditPrivateChatMetaDataModel({
    @Default('') String id,
    String? last_message_content,
    String? last_message_created_at,
  }) = _EditPrivateChatMetaDataModel;

  factory EditPrivateChatMetaDataModel.fromJson(Map<String, dynamic> json) =>
      _$EditPrivateChatMetaDataModelFromJson(json);
}
