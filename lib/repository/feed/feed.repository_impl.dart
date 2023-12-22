import 'package:injectable/injectable.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:my_app/api/feed/feed.api.dart';
import 'package:my_app/core/response/response.dart';
import 'package:my_app/domain/dto/feed/feed.dto.dart';
import 'package:my_app/repository/feed/feed.repository.dart';
import 'package:uuid/uuid.dart';

import '../../core/util/image.util.dart';

@Singleton(as: FeedRepository)
class FeedRepositoryImpl extends FeedRepository {
  final FeedApi _feedApi;

  FeedRepositoryImpl(this._feedApi);

  /// save feed and return its id
  @override
  Future<Response<String>> saveFeed(
      {required String content,
      required List<String> hashtags,
      required List<Asset> assets}) async {
    try {
      final fid = const Uuid().v1();

      // save images storage and get its download links
      final downloadLinks = assets.isEmpty
          ? <String>[]
          : await _feedApi.saveFeedImages(
              fid: fid, imageDataList: await ImageUtil.getImageData(assets));

      // save feed
      await _feedApi.saveFeed(FeedDto(
        fid: fid,
        hashtags: hashtags,
        content: content,
        images: downloadLinks,
        likeUidList: <String>[],
        commentCount: 0,
        shareCount: 0,
      ));
      return Response<String>(status: Status.success, data: fid);
    } catch (err) {
      return const Response<String>(
          status: Status.error, message: 'Fail to save feed');
    }
  }
}
