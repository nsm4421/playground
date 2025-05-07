import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create.freezed.dart';
part 'create.g.dart';

@freezed
class CreateFeedDto with _$CreateFeedDto {
  const factory CreateFeedDto({
    @Default(<String>[]) List<String> hashtags,
    @Default(<String>[]) List<String> captions,
    @Default(<String>[]) List<String> images,
  }) = _CreateFeedDto;


  factory CreateFeedDto.fromJson(Map<String, dynamic> json) =>
      _$CreateFeedDtoFromJson(json);
}