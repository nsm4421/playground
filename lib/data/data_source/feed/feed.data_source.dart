import 'dart:io';

import 'package:hot_place/domain/model/feed/feed.model.dart';
import 'package:hot_place/domain/model/feed/feed_with_author.model.dart';

abstract class FeedDataSource {
  Stream<List<FeedWithAuthorModel>> getFeedStream();

  Future<List<FeedWithAuthorModel>> getFeeds(
      {required int skip, required int take});

  Future<void> createFeed(FeedModel feed);

  Future<void> modifyFeed(FeedModel feed);

  Future<void> deleteFeedById(String feedId);

  Future<String> uploadFeedImageAndReturnDownloadLink(
      {required String feedId, required String filename, required File image});
}
