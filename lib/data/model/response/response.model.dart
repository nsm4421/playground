import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hot_place/core/constant/response.constant.dart';

part 'response.model.freezed.dart';

part 'response.model.g.dart';

/// wrapper for return of repository
@Freezed(genericArgumentFactories: true)
class ResponseModel<T> with _$ResponseModel<T> {
  const factory ResponseModel({
    @Default(true) bool isSuccess,
    @Default(200) int code,
    @Default('') String description,
    String? message,
    T? data,
  }) = _ResponseModel;

  factory ResponseModel.fromResponseType(
          {required ResponseType responseType, T? data, String? message}) =>
      ResponseModel(
          isSuccess: responseType.isSuccess,
          code: responseType.code,
          description: responseType.description,
          message: message,
          data: data);

  factory ResponseModel.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$ResponseModelFromJson<T>(json, fromJsonT);
}
