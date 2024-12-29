import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_feed.model.freezed.dart';

part 'edit_feed.model.g.dart';

@freezed
class CreateFeedDto with _$CreateFeedDto {
  const factory CreateFeedDto({
    required String content,
    @Default(<String>[]) List<String> hashtags,
  }) = _CreateFeedDto;

  factory CreateFeedDto.fromJson(Map<String, dynamic> json) =>
      _$CreateFeedDtoFromJson(json);
}

extension CreateFeedDtoExtension on CreateFeedDto {
  FormData toFormData({List<MultipartFile>? multiPartFile}) =>
      FormData.fromMap({
        'file': multiPartFile ?? [],
        'content': content,
        'hashtags': hashtags.join('|')
      });
}

@freezed
class ModifyFeedDto with _$ModifyFeedDto {
  const factory ModifyFeedDto({
    required int id,
    required String content,
    @Default(<String>[]) List<String> hashtags,
  }) = _ModifyFeedDto;

  factory ModifyFeedDto.fromJson(Map<String, dynamic> json) =>
      _$ModifyFeedDtoFromJson(json);
}

extension ModifyFeedDtoExtension on ModifyFeedDto {
  FormData toFormData({List<MultipartFile>? multiPartFile}) =>
      FormData.fromMap({
        'id': id,
        'file': multiPartFile ?? [],
        'content': content,
        'hashtags': hashtags.join('|')
      });
}
