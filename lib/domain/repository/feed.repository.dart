import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:my_app/core/utils/response_wrappper/response_wrapper.dart';
import 'package:my_app/domain/repository/repository.dart';

import '../model/feed/feed.model.dart';

abstract class FeedRepository extends Repository {
  Future<ResponseWrapper<FeedModel>> saveFeed(
      {required String content,
      required List<Asset> images,
      required List<String> hashtags});
}
