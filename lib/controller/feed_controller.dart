import 'dart:typed_data';

import 'package:chat_app/model/feed_model.dart';
import 'package:chat_app/repository/auth_repository.dart';
import 'package:chat_app/repository/feed_repository.dart';
import 'package:chat_app/screen/service/feed/s_add_feed.dart';
import 'package:chat_app/utils/alert_util.dart';
import 'package:chat_app/utils/image_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

final feedControllerProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final feedRepository = ref.watch(feedRepositoryProvider);
  return FeedController(
      authRepository: authRepository, feedRepository: feedRepository, ref: ref);
});

class FeedController {
  final AuthRepository authRepository;
  final FeedRepository feedRepository;
  final ProviderRef ref;
  List<FeedModel> feeds = [];
  XFile? xFile;
  Uint8List? imageData;

  FeedController(
      {required this.authRepository,
      required this.feedRepository,
      required this.ref});

  Future<void> fetchFeeds({required BuildContext context}) async {
    try {
      feeds.addAll(await feedRepository.fetchFeed());
    } catch (e) {
      AlertUtils.showSnackBar(context, 'Fetching Fails...');
    }
  }

  void goToAddFeedPage({required BuildContext context}) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AddFeedScreen(),
        ),
      );

  Future<void> selectImageFromGallery() async {
    final ImagePicker imagePicker = ImagePicker();
    xFile = await imagePicker.pickImage(source: ImageSource.gallery);
    imageData = await xFile?.readAsBytes();
  }

  void clearImage() {
    xFile = null;
    imageData = null;
  }

  Future<void> addFeed({
    required BuildContext context,
    required TextEditingController contentTEC,
    required List<TextEditingController> hashtagTECList,
  }) async {
    try {
      // validate
      final user = authRepository.getCurrentUser();
      if (user?.uid == null) {
        AlertUtils.showSnackBar(context, 'Need to login');
        return;
      }
      if (contentTEC.text.isEmpty || contentTEC.text.isEmpty) {
        AlertUtils.showSnackBar(context, 'content is missing...');
        return;
      }
      // 해시태그 문자열 수정하기
      String hashtagString = '';
      hashtagTECList.map((e) => e.text.trim()).toSet().forEach((v) {
        hashtagString = '$hashtagString#$v';
      });
      String? downloadLink;
      if (xFile != null && imageData != null) {
        final filename = ImageUtils.imageFileName(xFile!);
        final compressedImage = await ImageUtils.imageCompress(img: imageData!);
        downloadLink = await feedRepository.uploadImageAndGetDownloadLink(
            filename, compressedImage);
      }
      // firestore에 피드정보 저장
      const uuid = Uuid();
      await feedRepository.addFeed(FeedModel(
        feedId: uuid.v1(),
        content: contentTEC.text.trim(),
        uid: user?.uid,
        // TODO : current users's username
        // author: ,
        hashtags: hashtagString,
        image: downloadLink,
        createdAt: DateTime.now(),
      ));

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
