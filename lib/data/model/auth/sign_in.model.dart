import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in.model.freezed.dart';
part 'sign_in.model.g.dart';

@freezed
class SignInReqDto with _$SignInReqDto {
  factory SignInReqDto({required String email, required String password}) =
      _SignInReqDto;

  factory SignInReqDto.fromJson(Map<String, dynamic> json) =>
      _$SignInReqDtoFromJson(json);
}

@freezed
class SignInSuccessResDto with _$SignInSuccessResDto {
  factory SignInSuccessResDto(
      {required String message,
      required UserModel payload}) = _SignInSuccessResDto;

  factory SignInSuccessResDto.fromJson(Map<String, dynamic> json) =>
      _$SignInSuccessResDtoFromJson(json);
}

@freezed
class UserModel with _$UserModel {
  factory UserModel({
    required String id,
    required String email,
    required String username,
    required String token,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
