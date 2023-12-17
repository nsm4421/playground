import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:my_app/repository/base/repository.dart';

import '../../core/response/response.dart';

abstract class FeedRepository extends Repository {
  /// save feed and return its id
  Future<Response<String>> saveFeed(
      {required String content,
      required List<String> hashtags,
      required List<Asset> images});
}
