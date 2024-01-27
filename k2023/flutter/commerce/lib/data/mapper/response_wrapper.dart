import 'package:freezed_annotation/freezed_annotation.dart';

part '../../generated/response_wrapper.freezed.dart';

part '../../generated/response_wrapper.g.dart';

@Freezed(genericArgumentFactories: true)
class ResponseWrapper<T> with _$ResponseWrapper<T> {
  const factory ResponseWrapper({
    @Default('') String status,
    @Default('') String code,
    @Default('') String message,
    T? data,
  }) = _ResponseWrapper;


  factory ResponseWrapper.fromJson(Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$ResponseWrapperFromJson(json, fromJsonT);
}