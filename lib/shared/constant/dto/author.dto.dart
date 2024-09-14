import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'author.dto.freezed.dart';

part 'author.dto.g.dart';

@freezed
class AuthorDto with _$AuthorDto {
  const factory AuthorDto(
      {@Default('') String id,
      @Default('') String username,
      @Default('') String avatar_url}) = _AuthorDto;

  factory AuthorDto.fromJson(Map<String, dynamic> json) =>
      _$AuthorDtoFromJson(json);
}
