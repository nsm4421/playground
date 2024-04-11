import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../user/user.model.dart';

part 'open_chat_with_user.model.freezed.dart';

part 'open_chat_with_user.model.g.dart';

@freezed
class OpenChatWithUserModel with _$OpenChatWithUserModel {
  const factory OpenChatWithUserModel({
    @Default('') String id,
    @Default(UserModel()) UserModel host,
    @Default('') String title,
    @Default(<String>[]) List<String> hashtags,
    DateTime? created_at,
  }) = _OpenChatWithUserModel;

  factory OpenChatWithUserModel.fromJson(Map<String, dynamic> json) =>
      _$OpenChatWithUserModelFromJson(json);
}
