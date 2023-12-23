import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:my_app/api/feed/feed.api.dart';
import 'package:my_app/core/response/response.dart';
import 'package:my_app/domain/dto/feed/child_feed_comment.dto.dart';
import 'package:my_app/domain/dto/feed/feed.dto.dart';
import 'package:my_app/domain/dto/feed/parent_feed_comment.dto.dart';
import 'package:my_app/repository/feed/feed.repository.dart';
import 'package:uuid/uuid.dart';

import '../../core/util/image.util.dart';

@Singleton(as: FeedRepository)
class FeedRepositoryImpl extends FeedRepository {
  final FeedApi _feedApi;

  FeedRepositoryImpl(this._feedApi);

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
}
