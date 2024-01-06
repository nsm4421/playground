import 'package:freezed_annotation/freezed_annotation.dart';

import '../enums/api_status.enum.dart';

part 'api_response.freezed.dart';

part 'api_response.g.dart';

@Freezed(genericArgumentFactories: true)
class ApiResponse<T> with _$ApiResponse<T> {
  const factory ApiResponse(
      {@Default(ApiStatus.success) ApiStatus status,
      @Default('') String message,
      T? data}) = _ApiResponse;

  factory ApiResponse.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$ApiResponseFromJson<T>(json, fromJsonT);
}
