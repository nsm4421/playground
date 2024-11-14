import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create.freezed.dart';

part 'create.g.dart';

@freezed
class CreateReelsDto with _$CreateReelsDto {
  const factory CreateReelsDto({String? caption, @Default('') String video}) =
      _CreateReelsDto;

  factory CreateReelsDto.fromJson(Map<String, dynamic> json) =>
      _$CreateReelsDtoFromJson(json);
}
