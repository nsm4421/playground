import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'same_name.model.freezed.dart';

part 'same_name.model.g.dart';

@freezed
class SameNameModel with _$SameNameModel {
  const factory SameNameModel({
    @Default(<String>[]) region,
    @Default('') String keyword,
    @Default('') String selected_region
  }) = _SameNameModel;

  factory SameNameModel.fromJson(Map<String, dynamic> json) =>
      _$SameNameModelFromJson(json);
}
