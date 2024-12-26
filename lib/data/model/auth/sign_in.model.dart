import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in.model.freezed.dart';

part 'sign_in.model.g.dart';

@freezed
class SignInSuccessResDto with _$SignInSuccessResDto {
  factory SignInSuccessResDto(
      {required String message,
      required SignResInPayloadDto payload}) = _SignInSuccessResDto;

  factory SignInSuccessResDto.fromJson(Map<String, dynamic> json) =>
      _$SignInSuccessResDtoFromJson(json);
}

@freezed
class SignResInPayloadDto with _$SignResInPayloadDto {
  factory SignResInPayloadDto({
    required String id,
    required String email,
    required String username,
  }) = _SignResInPayloadDto;

  factory SignResInPayloadDto.fromJson(Map<String, dynamic> json) =>
      _$SignResInPayloadDtoFromJson(json);
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

  factory UserModel.from(
          {required SignResInPayloadDto dto, required String token}) =>
      UserModel(
          id: dto.id, email: dto.email, username: dto.username, token: token);
}
