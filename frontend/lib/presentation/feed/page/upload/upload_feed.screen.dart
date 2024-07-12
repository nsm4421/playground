import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hot_place/core/di/dependency_injection.dart';
import 'package:hot_place/presentation/auth/widget/loading.widget.dart';
import 'package:hot_place/presentation/feed/bloc/base/feed.bloc.dart';
import 'package:hot_place/presentation/feed/page/upload/hashtag.fragment.dart';
import 'package:hot_place/presentation/feed/page/upload/pick_image.fragment.dart';
import 'package:hot_place/presentation/feed/widget/feed_error.widget.dart';
import 'package:hot_place/presentation/setting/bloc/user.bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'feed_content.fragment.dart';

class UploadFeedScreen extends StatelessWidget {
  const UploadFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => getIt<FeedBloc>(),
        lazy: true,
        child: BlocConsumer<FeedBloc, FeedState>(listener: (context, state) {
          if (state is UploadingFeedSuccessState) {
            context.read<FeedBloc>().add(InitFeedEvent());
            context.pop();
          }
        }, builder: (context, state) {
          if (state is FeedLoadingState) {
            return const LoadingWidget("업로드 중입니다");
          } else if (State is FeedFailureState) {
            return const FeedErrorWidget("업로드 중 오류가 발생했습니다");
          }
          return const _View();
        }));
  }
}

class _View extends StatefulWidget {
  const _View({super.key});

  @override
  State<_View> createState() => _ViewState();
}

class _ViewState extends State<_View> {
  late TextEditingController _textEditingController;
  final ImagePicker _imagePicker = ImagePicker();

  List<String> _hashtags = [];
  List<File> _images = [];

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  _handlePop() {
    context.pop();
  }

  _handleSetHashtags(List<String> hashtags) => setState(() {
        _hashtags = hashtags;
      });

  _handleSetImages(List<File> images) => setState(() {
        _images = images;
      });

  _handleUpload() async {
    final currentUser = context.read<UserBloc>().state.user;
    final content = _textEditingController.text.trim();

    context.read<FeedBloc>().add(UploadingFeedEvent(
        user: currentUser,
        content: content,
        hashtags: _hashtags,
        images: _images));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: _handlePop,
          icon: const Icon(Icons.chevron_left),
        ),
        actions: [
          IconButton(onPressed: _handleUpload, icon: const Icon(Icons.check))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 이미지 선택
            PickImageFragment(
                imagePicker: _imagePicker,
                images: _images,
                handleSetImages: _handleSetImages),
            const SizedBox(height: 10),
            const Divider(indent: 20, endIndent: 20),
            const SizedBox(height: 10),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: FeedContentFragment(_textEditingController)),
            const SizedBox(height: 10),
            const Divider(indent: 20, endIndent: 20),
            const SizedBox(height: 10),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: HashtagFragment(
                  hashtags: _hashtags,
                  handleSetHashtags: _handleSetHashtags,
                )),
            const SizedBox(height: 30)
          ],
        ),
      ),
    );
  }
}
