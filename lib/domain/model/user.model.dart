import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_app/data/dto/auth/user/user.dto.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'user.model.freezed.dart';

part 'user.model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({String? id, String? email, String? nickname}) =
      _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

extension UserModelExt on UserModel {
  UserDto modelToDto() =>
      UserDto(id: id ?? '', email: email ?? '', nickname: nickname ?? '');
}
