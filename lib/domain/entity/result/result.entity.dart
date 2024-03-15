import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hot_place/data/model/response/response.model.dart';

part 'result.entity.freezed.dart';

/// wrapper for return of usecase
@freezed
class ResultEntity<T> with _$ResultEntity<T> {
  const factory ResultEntity.success(T data) = Success;

  const factory ResultEntity.failure(
      {required int code, required String description}) = Error;

  factory ResultEntity.fromResponse(
          ResponseModel<T> response) =>
      response.isSuccess
          ? ResultEntity<T>.success(response.data as T)
          : ResultEntity<T>.failure(
              code: response.code, description: response.description);
}
