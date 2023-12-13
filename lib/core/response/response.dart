import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'response.freezed.dart';

part 'response.g.dart';

enum Status {
  success,
  error;
}

@Freezed(genericArgumentFactories: true)
class Response<T> with _$Response<T> {
  const factory Response({
    required Status status,
    @Default('') String code,
    @Default('') String message,
    T? data,
  }) = _Response;

  factory Response.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$ResponseFromJson<T>(json, fromJsonT);
}
