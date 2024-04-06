import 'dart:io';

import 'package:hot_place/domain/model/feed/feed.model.dart';

abstract class FeedDataSource {
  Future<void> createFeed(FeedModel feed);

  Future<void> modifyFeed(FeedModel feed);

  Future<void> deleteFeedById(String feedId);

  Future<String> uploadFeedImageAndReturnDownloadLink(
      {required String feedId, required String filename, required File image});
}
