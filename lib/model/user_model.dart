import 'package:freezed_annotation/freezed_annotation.dart';

part '../generated/user_model.g.dart';

part '../generated/user_model.freezed.dart';

/**
 * 사용자
 ** uid : document id
 ** username : 유저명
 ** description : 자기소개
 ** profileUrl : 프로필 이미지
 ** createdAt : 회원가입 시각
 ** lastSeen : 가장 마지막 로그인 시간
 ** removedAt : 회원 탈퇴 시간
 */
@freezed
sealed class UserModel with _$UserModel {
  factory UserModel({
    String? uid,
    String? username,
    String? description,
    String? profileUrl,
    DateTime? createdAt,
    DateTime? lastSeen,
    DateTime? removedAt,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
