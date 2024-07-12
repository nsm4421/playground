import 'dart:io';

import 'package:hot_place/domain/model/feed/base/feed.model.dart';

abstract interface class RemoteFeedDataSource {
  Stream<List<FeedModel>> getFeedStream();

  Future<List<FeedModel>> getFeedsByHashtag(String hashtag,
      {int skip = 0, int take = 100});

  Future<void> createFeed(FeedModel feed);

  Future<void> modifyFeed(FeedModel feed);

  Future<void> deleteFeedById(String feedId);

  Future<String> uploadFeedImageAndReturnDownloadLink(
      {required String feedId, required String filename, required File image});
}
