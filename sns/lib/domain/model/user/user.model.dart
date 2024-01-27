import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.model.freezed.dart';

part 'user.model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel(
      {String? uid,
      String? email,
      String? nickname,
      @Default(<String>[]) List<String> profileImageUrls,
      @Default(<String>[]) List<String> followingUidList,
      DateTime? createdAt}) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
