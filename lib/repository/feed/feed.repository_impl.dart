import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:my_app/api/feed/feed.api.dart';
import 'package:my_app/core/response/response.dart';
import 'package:my_app/domain/dto/feed/child_feed_comment.dto.dart';
import 'package:my_app/domain/dto/feed/feed.dto.dart';
import 'package:my_app/domain/dto/feed/parent_feed_comment.dto.dart';
import 'package:my_app/domain/model/feed/feed.model.dart';
import 'package:my_app/repository/feed/feed.repository.dart';
import 'package:uuid/uuid.dart';

import '../../api/auth/auth.api.dart';
import '../../core/constant/feed.enum.dart';
import '../../core/util/image.util.dart';

@Singleton(as: FeedRepository)
class FeedRepositoryImpl extends FeedRepository {
  final AuthApi _authApi;
  final FeedApi _feedApi;

  FeedRepositoryImpl({required AuthApi authApi, required FeedApi feedApi})
      : _authApi = authApi,
        _feedApi = feedApi;

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
        cidList: <String>[],
        shareCount: 0,
      ));
      return Response<String>(status: Status.success, data: fid);
    } catch (err) {
      debugPrint(err.toString());
      return const Response<String>(
          status: Status.error, message: 'Fail to save feed');
    }
  }

  @override
  Future<Response<String>> saveFeedComment(
      {required String fid,
      required String? parentCid,
      required String content}) async {
    try {
      final cid = const Uuid().v1(); // comment id
      parentCid == null
          ? await _feedApi.saveParentComment(
              ParentFeedCommentDto(cid: cid, fid: fid, content: content))
          : await _feedApi.saveChildComment(ChildFeedCommentDto(
              cid: cid, fid: fid, content: content, parentCid: parentCid));
      return Response(status: Status.success, data: cid);
    } catch (err) {
      debugPrint(err.toString());
      return const Response<String>(
          status: Status.error, message: 'Fail to save child comment');
    }
  }

  /// search feeds by hashtag or content
  @override
  Future<Response<List<FeedModel>>> searchFeed(
      {required SearchOption option, required String keyword}) async {
    try {
      List<FeedModel> feeds = [];
      switch (option) {
        case SearchOption.hashtag:
          feeds = (await _feedApi.findFeedByHashtag(keyword))
              .map((e) => e.toModel())
              .toList();
        case SearchOption.content:
          feeds = (await _feedApi.findFeedByContent(keyword))
              .map((e) => e.toModel())
              .toList();
        case SearchOption.nickname:
          throw Exception(
              "[FeedRepositoryImpl]search options for feed are only hashtag and content");
      }
      return Response<List<FeedModel>>(
          status: Status.success,
          data: await Future.wait(feeds.map((feed) async {
            final user = await _authApi.findUserByUid(feed.uid!);
            return feed.copyWith(
                nickname: user.nickname,
                profileImageUrl: user.profileImageUrls.isNotEmpty
                    ? user.profileImageUrls[0]
                    : null);
          })));
    } catch (err) {
      debugPrint(err.toString());
      return Response<List<FeedModel>>(
          status: Status.error, message: err.toString());
    }
  }
}
