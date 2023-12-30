import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:my_app/repository/base/repository.dart';

import '../../core/constant/feed.enum.dart';
import '../../core/response/response.dart';
import '../../domain/model/feed/feed.model.dart';

abstract class FeedRepository extends Repository {
  /// save feed and return its id
  Future<Response<String>> saveFeed(
      {required String content,
      required List<String> hashtags,
      required List<Asset> assets});

  /// save feed comment and return its id
  /// if parentCid is null, then save parent comment, else save child comment
  Future<Response<String>> saveFeedComment(
      {required String fid,
      required String? parentCid,
      required String content});

  /// search feed by hashtag or content
  Future<Response<List<FeedModel>>> searchFeed(
      {required SearchOption option, required String keyword});
}
