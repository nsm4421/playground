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

import '../../api/notification/notification.api.dart';
import '../../api/user/user.api.dart';
import '../../core/constant/feed.enum.dart';
import '../../core/constant/notification.eum.dart';
import '../../core/util/image.util.dart';
import '../../domain/dto/notification/notification.dto.dart';

@Singleton(as: FeedRepository)
class FeedRepositoryImpl extends FeedRepository {
  final UserApi _userApi;
  final FeedApi _feedApi;
  final NotificationApi _notificationApi;

  FeedRepositoryImpl(
      {required UserApi userApi,
      required FeedApi feedApi,
      required NotificationApi notificationApi})
      : _userApi = userApi,
        _feedApi = feedApi,
        _notificationApi = notificationApi;

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
      // save comment
      final cid = const Uuid().v1(); // comment id
      parentCid == null
          ? await _feedApi.saveParentComment(
              ParentFeedCommentDto(cid: cid, fid: fid, content: content))
          : await _feedApi.saveChildComment(ChildFeedCommentDto(
              cid: cid, fid: fid, content: content, parentCid: parentCid));
      // send notification on author
      await _notificationApi.createNotification(NotificationDto(
        receiverUid: await _feedApi.getUidByFid(fid) ?? '',
        title: 'comment on my feed',
        type: NotificationType.comment,
        message: content,
        createdAt: DateTime.now(),
      ));
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
            final user = await _userApi.findUserByUid(feed.uid!);
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

  @override
  Future<Response<void>> likeFeed(String fid) async {
    try {
      // like feed
      await _feedApi.likeFeed(fid);
      // get current user nickname
      final nickname = (await _userApi.getCurrentUser())?.nickname;
      // send notification
      await _notificationApi.createNotification(NotificationDto(
          type: NotificationType.like,
          receiverUid: await _feedApi.getUidByFid(fid) ?? '',
          title: 'Like On My Feed',
          message: '${nickname ?? 'somebody'} like on my feed',
          createdAt: DateTime.now()));
      return const Response<void>(status: Status.success);
    } catch (err) {
      return Response<void>(status: Status.error, message: err.toString());
    }
  }

  @override
  Future<Response<void>> dislikeFeed(String fid) async {
    try {
      await _feedApi.dislikeFeed(fid);
      return const Response<void>(status: Status.success);
    } catch (err) {
      return Response<void>(status: Status.error, message: err.toString());
    }
  }
}
