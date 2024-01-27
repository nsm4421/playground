import 'package:multi_image_picker/multi_image_picker.dart';

abstract class WriteFeedEvent {
  const WriteFeedEvent();
}

/// 업로드 화면 초기화
class WriteFeedInitializedEvent extends WriteFeedEvent {}

/// 피드 업로드
class SubmitFeedEvent extends WriteFeedEvent {
  final String content;
  final List<Asset> images;
  final List<String> hashtags;

  SubmitFeedEvent(
      {required this.content, required this.images, required this.hashtags});
}
