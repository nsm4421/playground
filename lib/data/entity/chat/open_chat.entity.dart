import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hot_place/data/entity/user/user.entity.dart';

part 'open_chat.entity.freezed.dart';

part 'open_chat.entity.g.dart';

@freezed
class OpenChatEntity with _$OpenChatEntity {
  const factory OpenChatEntity({
    String? id,
    UserEntity? user,
    String? title,
    @Default(<String>[]) List<String> hashtags,
    DateTime? createdAt,
  }) = _OpenChatEntity;

  factory OpenChatEntity.fromJson(Map<String, dynamic> json) =>
      _$OpenChatEntityFromJson(json);
}
