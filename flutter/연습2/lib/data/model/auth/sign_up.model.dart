import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up.model.freezed.dart';

part 'sign_up.model.g.dart';

@freezed
class SignUpReqDto with _$SignUpReqDto {
  const factory SignUpReqDto({
    @Default('') String email,
    @Default('') String username,
    @Default('') String password,
    @Default('') String nickname,
  }) = _SignUpReqDto;

  factory SignUpReqDto.fromJson(Map<String, dynamic> json) =>
      _$SignUpReqDtoFromJson(json);
}

extension SignUpReqDtoExtension on SignUpReqDto {
  FormData toFormData(MultipartFile multiPartFile) =>
      FormData.fromMap({'file': multiPartFile, ...this.toJson()});
}
