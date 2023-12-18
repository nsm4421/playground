import 'package:multi_image_picker/multi_image_picker.dart';

abstract class PostEvent {
  const PostEvent();
}

class InitPostEvent extends PostEvent {}

/// user submit post
class SubmitPostEvent extends PostEvent {
  final String content;
  final List<String> hashtags;
  final List<Asset> images;

  SubmitPostEvent(
      {required this.content, required this.hashtags, required this.images});
}
