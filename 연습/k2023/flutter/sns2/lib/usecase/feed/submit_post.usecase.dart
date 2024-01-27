import 'package:my_app/repository/feed/feed.repository.dart';

import 'package:multi_image_picker/multi_image_picker.dart';
import '../../core/response/response.dart';
import '../base/remote.usecase.dart';

class SubmitPostUsecase extends RemoteUsecase<FeedRepository> {
  SubmitPostUsecase(
      {required this.content, required this.images, required this.hashtags});

  final String content;
  final List<Asset> images;
  final List<String> hashtags;

  @override
  Future call(FeedRepository repository) async {
    if (content.isEmpty) {
      return const Response<String>(
          status: Status.warning, message: 'Content is empty');
    }
    return await repository.saveFeed(
        content: content, assets: images, hashtags: hashtags);
  }
}
