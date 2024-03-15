import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hot_place/core/constant/response.constant.dart';

part 'create_post.state.freezed.dart';

@freezed
class CreatePostState with _$CreatePostState {
  const factory CreatePostState({
    @Default(Status.initial) Status status,
    @Default('') String content,
    @Default(<String>[]) List<String> hashtags,
    @Default(<String>[]) List<String> images,
    @Default(<XFile>[]) List<XFile> assets,
  }) = _CreatePostState;
}
