import 'dart:typed_data';

import 'package:chat_app/controller/feed_controller.dart';
import 'package:chat_app/utils/alert_util.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:chat_app/model/feed_model.dart';
import 'package:chat_app/screen/widget/w_box.dart';
import 'package:chat_app/utils/image_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class AddFeedScreen extends ConsumerStatefulWidget {
  const AddFeedScreen({super.key});

  @override
  ConsumerState<AddFeedScreen> createState() => _AddFeedScreenState();
}

class _AddFeedScreenState extends ConsumerState<AddFeedScreen> {
  late TextEditingController _contentTEC;
  late List<TextEditingController> _hashtagTECList;

  @override
  void initState() {
    super.initState();
    _contentTEC = TextEditingController();
    _hashtagTECList = [TextEditingController()];
  }

  @override
  void dispose() {
    super.dispose();
    _contentTEC.dispose();
    for (var element in _hashtagTECList) {
      element.dispose();
    }
  }

  /// 해시태그 추가
  /// 해시태그 개수 최대 3개, _hashtagTEC List에 TextEditingController 추가
  _handleAddHashtag() {
    if (_hashtagTECList.length >= 3) {
      AlertUtils.showSnackBar(context, 'Maximum of number of hashtag is 3');
      return;
    }
    setState(() {
      _hashtagTECList.add(TextEditingController());
    });
  }

  /// 해시태그 삭제
  /// _hashtagTEC List에 특정 index 원소 삭제
  _handleDeleteHashtag(int idx) {
    setState(() {
      _hashtagTECList.removeAt(idx);
    });
  }

  /// 이미지 선택
  _handleSelectImageFromGallery() async {
    await ref.watch(feedControllerProvider).selectImageFromGallery();
    setState(() {});
  }

  /// 이미지 삭제
  _handleClearImage() {
    setState(() {
      ref.watch(feedControllerProvider).clearImage();
    });
  }

  _handleUpload() => ref.watch(feedControllerProvider).addFeed(
        context: context,
        contentTEC: _contentTEC,
        hashtagTECList: _hashtagTECList,
      );

  AppBar _appBar() => AppBar(
        centerTitle: true,
        title: Text(
          "Add Feed",
          style: GoogleFonts.lobster(
            fontWeight: FontWeight.bold,
            fontSize: 32,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _handleUpload,
            icon: const Icon(
              Icons.upload_rounded,
              color: Colors.teal,
              size: 30,
            ),
          )
        ],
      );

  Widget _contentTile() => ExpansionTile(
        title: const Row(
          children: [
            Icon(Icons.book),
            Width(10),
            Text(
              "Content",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Height(10),
                TextFormField(
                    controller: _contentTEC,
                    maxLines: 10,
                    maxLength: 1000,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) => (v == null || v.isEmpty)
                        ? "Content must not be empty"
                        : null),
              ],
            ),
          )
        ],
      );

  Widget _hashtagTile() => ExpansionTile(
        title: const Row(
          children: [
            Icon(Icons.tag),
            Width(10),
            Text(
              "Hashtag",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Height(15),
              ...List.generate(
                _hashtagTECList.length,
                (idx) => TextFormField(
                  onChanged: (v) {
                    v.replaceAll("#", "");
                  },
                  controller: _hashtagTECList[idx],
                  maxLines: 1,
                  maxLength: 10,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.tag),
                    suffixIcon: IconButton(
                      onPressed: () {
                        _handleDeleteHashtag(idx);
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ),
                  validator: (v) => (v == null || v.isEmpty)
                      ? "Content must not be empty"
                      : null,
                ),
              ),
              if (_hashtagTECList.length < 3)
                IconButton(
                  onPressed: () {
                    _handleAddHashtag();
                  },
                  icon: const Row(
                    children: [
                      Text("Add Hashtag?"),
                      Width(15),
                      Icon(Icons.add),
                    ],
                  ),
                )
            ]),
          )
        ],
      );

  Widget _imageTile() => ExpansionTile(
        title: const Row(
          children: [
            Icon(Icons.image),
            Width(10),
            Text(
              "Image",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        children: [
          (ref.watch(feedControllerProvider).imageData == null)
              ? GestureDetector(
                  onTap: _handleSelectImageFromGallery,
                  child: const Column(
                    children: [
                      Height(30),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_photo_alternate_outlined,
                            size: 30,
                          ),
                          Height(10),
                          Text(
                            "Select Image From Gallery",
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                      Height(30),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      Positioned(
                        child: Image.memory(
                          ref.watch(feedControllerProvider).imageData!,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: IconButton(
                          onPressed: _handleClearImage,
                          icon: const Icon(
                            Icons.dangerous,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            const Height(30),
            _contentTile(),
            const Height(15),
            _hashtagTile(),
            const Height(15),
            _imageTile(),
            const Height(20),
          ],
        ),
      ),
    );
  }
}
