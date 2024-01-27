import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../constant/enums/status.enum.dart';

part 'response_wrapper.freezed.dart';

part 'response_wrapper.g.dart';

@Freezed(genericArgumentFactories: true)
class ResponseWrapper<T> with _$ResponseWrapper<T> {
  const factory ResponseWrapper({
    required ResponseStatus status,
    @Default('') String code,
    @Default('') String message,
    T? data,
  }) = _ResponseWrapper;

  factory ResponseWrapper.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$ResponseWrapperFromJson<T>(json, fromJsonT);
}
