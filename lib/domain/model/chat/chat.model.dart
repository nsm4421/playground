import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_app/domain/model/user/user.model.dart';

import '../../../core/constant/chat.enum.dart';

part 'chat.model.freezed.dart';

part 'chat.model.g.dart';

@freezed
class ChatModel with _$ChatModel {
  const factory ChatModel(
      {String? chatId,
      ChatType? type,
      @Default(<UserModel>{}) Set<UserModel> users,
      DateTime? createdAt}) = _ChatModel;

  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      _$ChatModelFromJson(json);
}
