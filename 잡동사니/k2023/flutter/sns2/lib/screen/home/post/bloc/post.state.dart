import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

part 'post.state.freezed.dart';

enum PostStatus {
  initial,
  loading,
  error,
  success;
}

@freezed
class PostState with _$PostState {
  const factory PostState({
    @Default(PostStatus.initial) PostStatus status,
    @Default('') String content,
    @Default(<String>[]) List<String> hashtags,
    @Default(<Asset>[]) List<Asset> images,
  }) = _PostState;
}
