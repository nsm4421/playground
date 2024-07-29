import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:portfolio/features/auth/data/model/account.model.dart';

part 'private_chat_message_with_user.model.freezed.dart';

part 'private_chat_message_with_user.model.g.dart';

@freezed
class PrivateChatMessageWithUserModel with _$PrivateChatMessageWithUserModel {
  const factory PrivateChatMessageWithUserModel(
      {@Default('') String id,
      @Default('') String chat_id, // 유저 id를 연결를 _로 연결한 문자열
      @Default(AccountModel()) AccountModel sender,
      @Default(AccountModel()) AccountModel receiver,
      @Default('') String content,
      DateTime? created_at}) = _PrivateChatMessageWithUserModel;

  factory PrivateChatMessageWithUserModel.fromJson(Map<String, dynamic> json) =>
      _$PrivateChatMessageWithUserModelFromJson(json);
}

@freezed
class PrivateChatMessageWithUserModelForRpc
    with _$PrivateChatMessageWithUserModelForRpc {
  const factory PrivateChatMessageWithUserModelForRpc(
      {@Default('') String id,
      @Default('') String chat_id, // 유저 id를 연결를 _로 연결한 문자열
      @Default('') String sender_uid,
      @Default('') String sender_nickname,
      @Default('') String sender_profile_image,
      @Default('') String receiver_uid,
      @Default('') String receiver_nickname,
      @Default('') String receiver_profile_image,
      @Default('') String content,
      DateTime? created_at}) = _PrivateChatMessageWithUserModelForRpc;

  factory PrivateChatMessageWithUserModelForRpc.fromJson(
          Map<String, dynamic> json) =>
      _$PrivateChatMessageWithUserModelForRpcFromJson(json);
}
