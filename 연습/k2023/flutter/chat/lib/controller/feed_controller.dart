import 'dart:typed_data';

import 'package:chat_app/model/comment_model.dart';
import 'package:chat_app/model/feed_model.dart';
import 'package:chat_app/model/user_model.dart';
import 'package:chat_app/repository/auth_repository.dart';
import 'package:chat_app/repository/feed_repository.dart';
import 'package:chat_app/screen/service/feed/f_comment.dart';
import 'package:chat_app/screen/service/feed/s_add_feed.dart';
import 'package:chat_app/utils/alert_util.dart';
import 'package:chat_app/utils/image_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

final feedControllerProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final feedRepository = ref.watch(feedRepositoryProvider);
  return FeedController(
      authRepository: authRepository, feedRepository: feedRepository, ref: ref);
});

class FeedController {
  final AuthRepository _authRepository;
  final FeedRepository _feedRepository;
  final ProviderRef _ref;

  FeedController(
      {required AuthRepository authRepository,
      required FeedRepository feedRepository,
      required ProviderRef<dynamic> ref})
      : _authRepository = authRepository,
        _feedRepository = feedRepository,
        _ref = ref;

  /// 피드 추가하기 페이지로 이동하기
  void goToAddFeedPage({required BuildContext context}) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AddFeedScreen(),
        ),
      );

  /// 댓글 페이지 띄우기
  showCommentFragment(
          {required BuildContext context, required String feedId}) =>
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) => CommentFragment(feedId),
      );

  /// 피드 추가하기
  Future<void> addFeed({
    required BuildContext context,
    required TextEditingController contentTEC,
    required Uint8List? imageData,
    required List<TextEditingController> hashtagTECList,
  }) async {
    try {
      // validate
      final uid = _authRepository.getCurrentUser()?.uid;
      final content = contentTEC.text.trim();
      if (uid == null) {
        AlertUtils.showSnackBar(context, 'Need to login');
        return;
      }
      if (content.isEmpty) {
        AlertUtils.showSnackBar(context, 'content is missing...');
        return;
      }

      // feed id
      const uuid = Uuid();
      final fid = uuid.v1().toString();

      // upload image
      String? downloadLink;
      if (imageData != null) {
        final compressedImage = await ImageUtils.imageCompress(img: imageData);
        downloadLink = await _feedRepository.uploadImageAndGetDownloadLink(
            fid, compressedImage);
      }

      // save feed ub firestore
      await _feedRepository.addFeed(
        FeedModel(
          feedId: fid,
          content: contentTEC.text.trim(),
          uid: uid,
          hashtags:
              hashtagTECList.map((tec) => tec.text.trim()).toSet().toList(),
          image: downloadLink,
          createdAt: DateTime.now(),
        ),
      );

      if (context.mounted) {
        AlertUtils.showSnackBar(context, 'Success');
        Navigator.pop(context);
      }
    } catch (e) {
      AlertUtils.showSnackBar(context, 'Error occurs...');
      return;
    }
  }

  /// 댓글 추가하기
  Future<void> addComment({
    required BuildContext context,
    required String feedId,
    required TextEditingController contentTEC,
  }) async {
    try {
      // validate
      final uid = _authRepository.getCurrentUser()?.uid;
      final content = contentTEC.text.trim();
      if (uid == null) {
        AlertUtils.showSnackBar(context, 'Need to login');
        return;
      }
      if (contentTEC.text.isEmpty || contentTEC.text.isEmpty) {
        AlertUtils.showSnackBar(context, 'content is missing...');
        return;
      }

      // comment id
      const uuid = Uuid();
      final commentId = uuid.v1().toString();

      // save comment on firestore
      await _feedRepository.addComment(
        CommentModel(
          uid: uid,
          feedId: feedId,
          commentId: commentId,
          content: content,
          createdAt: DateTime.now(),
        ),
      );

      if (context.mounted) {
        AlertUtils.showSnackBar(context, 'Success');
        Navigator.pop(context);
      }
    } catch (e) {
      AlertUtils.showSnackBar(context, 'Error occurs...');
      return;
    }
  }
}
