import 'package:flutter/foundation.dart';
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
    required String access_token,
  }) = _SignResInPayloadDto;

  factory SignResInPayloadDto.fromJson(Map<String, dynamic> json) =>
      _$SignResInPayloadDtoFromJson(json);
}


