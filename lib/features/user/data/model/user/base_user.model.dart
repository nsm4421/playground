import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_user.model.freezed.dart';

part 'base_user.model.g.dart';

@freezed
class BaseUserModel with _$BaseUserModel {
  const factory BaseUserModel({
    @Default('') String uid,
    String? email,
    String? profileImageUrl,
    String? username,
  }) = _BaseUserModel;

  factory BaseUserModel.fromJson(Map<String, dynamic> json) =>
      _$BaseUserModelFromJson(json);
}
