import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'author.model.freezed.dart';

part 'author.model.g.dart';

@freezed
class AuthorDto with _$AuthorDto {
  const factory AuthorDto({
    @Default('') String id,
    @Default('') String username,
    @Default('') String profileImage,
  }) = _AuthorDto;

  factory AuthorDto.fromJson(Map<String, dynamic> json) =>
      _$AuthorDtoFromJson(json);
}
