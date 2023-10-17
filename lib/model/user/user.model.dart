import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.model.freezed.dart';

part 'user.model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    @Default('') String? email, // 이메일
    @Default('') String? password, // 비밀번호
    @Default('') String? nickname, // 닉네임
    @Default(-1) int? age, // 연령
    @Default('') String? phone, // 전화번호
    @Default('') String? city, // 도시
    @Default('') String? introduce, // 자기소개
    @Default(-1) int? height, // 몸무게
    @Default('') String? job, // 직업
    @Default('') String? ideal, // 이상형
    @Default('') String? profileImageUrl, // 프로필 이미지 Url
    @Default(<String>[]) List<String> imageUrls, // 이미지 Url
    DateTime? createdAt, // 생성시간
    DateTime? lastSeen, // 가장 최근 접속시간
    DateTime? removedAt, // 삭제시간
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
