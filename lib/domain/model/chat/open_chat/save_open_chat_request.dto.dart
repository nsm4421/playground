import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'save_open_chat_request.dto.freezed.dart';

part 'save_open_chat_request.dto.g.dart';

@freezed
class SaveOpenChatRequestDto with _$SaveOpenChatRequestDto {
  const factory SaveOpenChatRequestDto({@Default('') String title}) =
      _SaveOpenChatRequestDto;

  factory SaveOpenChatRequestDto.fromJson(Map<String, dynamic> json) =>
      _$SaveOpenChatRequestDtoFromJson(json);
}
