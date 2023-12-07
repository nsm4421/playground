import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:my_app/domain/repository/feed.repository.dart';

import '../../../../core/constant/enums/status.enum.dart';
import '../../../../core/utils/exception/error_response.dart';
import '../../../model/result/result.dart';
import '../../base/remote.usecase.dart';

class WriteFeedUseCase extends RemoteUseCase<FeedRepository> {
  WriteFeedUseCase(
      {required this.content, required this.images, required this.hashtags});

  final String content;
  final List<Asset> images;
  final List<String> hashtags;

  @override
  Future call(FeedRepository repository) async {
    final result = await repository.saveFeed(
        content: content, images: images, hashtags: hashtags);
    return result.status == ResponseStatus.success
        ? const Result<void>.success(null)
        : Result<void>.failure(ErrorResponse(
            status: 'ERROR', code: result.code, message: result.message));
  }
}
