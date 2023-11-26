import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/constant/enums/sign_up.enum.dart';

part 'user.model.freezed.dart';

part 'user.model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel(
      {String? uid,
      String? email,
      String? nickname,
      Sex? sex,
      DateTime? birthday,
      @Default(<String>[]) List<String> profileImageUrls,
      String? description,
      DateTime? createdAt}) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
