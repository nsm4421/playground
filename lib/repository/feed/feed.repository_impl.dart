import 'package:injectable/injectable.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:my_app/api/feed/feed,api.dart';
import 'package:my_app/core/response/response.dart';
import 'package:my_app/domain/dto/feed/feed.dto.dart';
import 'package:my_app/repository/feed/feed.repository.dart';

@Singleton(as: FeedRepository)
class FeedRepositoryImpl extends FeedRepository {
  final FeedApi _feedApi;

  FeedRepositoryImpl(this._feedApi);

  /// save feed and return its id
  @override
  Future<Response<String>> saveFeed(
      {required String content,
      required List<String> hashtags,
      required List<Asset> images}) async {
    try {
      // TODO : save images
      final downloadLinks = [];
      if (images.isNotEmpty) {}
      final FeedDto feed = FeedDto(
        hashtags: hashtags,
        content: content,
        images: downloadLinks,
        likeCount: 0,
        commentCount: 0,
        shareCount: 0,
      );

      final fid = await _feedApi.saveFeed(feed);
      return Response<String>(status: Status.success, data: fid);
    } catch (err) {
      return const Response<String>(
          status: Status.error, message: 'Fail to save feed');
    }
  }
}
