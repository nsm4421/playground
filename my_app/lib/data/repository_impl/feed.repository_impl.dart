import 'dart:typed_data';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:injectable/injectable.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:my_app/core/constant/enums/status.enum.dart';
import 'package:my_app/data/dto/feed/feed.dto.dart';
import 'package:my_app/data/dto/feed/feed_comment.dto.dart';
import 'package:my_app/data/mapper/feed_mapper.dart';
import 'package:my_app/domain/model/feed/feed.model.dart';
import 'package:my_app/domain/model/feed/feed_comment.model.dart';
import 'package:my_app/domain/repository/feed.repository.dart';
import 'package:uuid/uuid.dart';

import '../../core/utils/logging/custom_logger.dart';
import '../../core/utils/response_wrappper/response_wrapper.dart';
import '../data_source/remote/feed/feed.api.dart';

@Singleton(as: FeedRepository)
class FeedRepositoryImpl extends FeedRepository {
  final FeedApi _feedApi;

  static const int _quality = 100; // 이미지 압축 해상도

  FeedRepositoryImpl(this._feedApi);

  /// 피드 저장
  @override
  Future<ResponseWrapper<void>> saveFeed(
      {required String content,
      required List<Asset> images,
      required List<String> hashtags}) async {
    try {
      // 이미지 저장 후, 다운로드 링크 가져오기
      final feedId = (const Uuid()).v1();
      final downloadLinks = images.isEmpty
          ? <String>[]
          : await _uploadFeedImagesAndGetDownloadLinks(
              feedId: feedId, images: images);
      // 피드 저장
      final FeedDto feed = FeedDto(
          feedId: feedId,
          content: content,
          images: downloadLinks,
          hashtags: hashtags,
          createdAt: DateTime.now());
      await _feedApi.saveFeed(feedId: feedId, feed: feed);
      return const ResponseWrapper(status: ResponseStatus.success);
    } catch (err) {
      CustomLogger.logger.e(err);
      return const ResponseWrapper(
          status: ResponseStatus.error, message: "Fail to create feed");
    }
  }

  /// 댓글 저장하기
  @override
  Future<ResponseWrapper<void>> saveFeedComment(
      {required String content, required String feedId}) async {
    try {
      final commentId = (const Uuid()).v1();
      final comment = FeedCommentDto(
          feedId: feedId,
          commentId: commentId,
          content: content,
          createdAt: DateTime.now());
      await _feedApi.saveComment(
          feedId: feedId, commentId: commentId, comment: comment);
      return const ResponseWrapper(status: ResponseStatus.success);
    } catch (err) {
      CustomLogger.logger.e(err);
      return const ResponseWrapper(
          status: ResponseStatus.error, message: "Fail to save comment");
    }
  }

  /// 피드 목록 가져오기
  @override
  Future<ResponseWrapper<List<FeedModel>>> getFeeds(
      {int skip = 0, int take = 10}) async {
    try {
      final feeds = (await _feedApi.getFeeds(skip: skip, take: take))
          .map((e) => e.toModel())
          .toList();
      return ResponseWrapper(status: ResponseStatus.success, data: feeds);
    } catch (err) {
      CustomLogger.logger.e(err);
      return const ResponseWrapper(
          status: ResponseStatus.error, message: "Fail to get feed");
    }
  }

  /// 댓글 목록 가져오기
  @override
  Future<ResponseWrapper<List<FeedCommentModel>>> getFeedComments(String feedId,
      {int skip = 0, int take = 10}) async {
    try {
      final comments = (await _feedApi.getFeedComments(
              feedId: feedId, take: take, skip: skip))
          .map((e) => e.toModel())
          .toList();
      return ResponseWrapper(status: ResponseStatus.success, data: comments);
    } catch (err) {
      CustomLogger.logger.e(err);
      return const ResponseWrapper(
          status: ResponseStatus.error, message: "Fail to get comments");
    }
  }

  /// 이미지 저장 후, 다운로드 링크 얻기
  Future<List<String>> _uploadFeedImagesAndGetDownloadLinks({
    required String feedId,
    required List<Asset> images,
  }) async {
    List<String> downloadLinks = [];
    for (final image in images) {
      // 이미지 압축
      Uint8List compressedImageData = await image
          .getByteData()
          .then((byte) => byte.buffer.asUint8List())
          .then((data) =>
              FlutterImageCompress.compressWithList(data, quality: _quality));
      final filename =
          '${feedId}_${DateTime.now().millisecondsSinceEpoch.toString()}.jpg';
      final downloadUrl = await _feedApi.saveFeedImage(
          feedId: feedId, filename: filename, imageData: compressedImageData);
      downloadLinks.add(downloadUrl);
    }
    return downloadLinks;
  }
}
