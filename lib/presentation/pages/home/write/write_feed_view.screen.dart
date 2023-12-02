import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

import 'bloc/write_feed/write_feed.bloc.dart';
import 'bloc/write_feed/write_feed.event.dart';
import 'component/carousel_slider.widget.dart';
import 'component/hashtag_textfield.widget.dart';
import 'component/select_image.widget.dart';
import 'component/content_textfield.widget.dart';

class WriteFeedViewScreen extends StatefulWidget {
  const WriteFeedViewScreen({super.key});

  @override
  State<WriteFeedViewScreen> createState() => _WriteFeedViewState();
}

class _WriteFeedViewState extends State<WriteFeedViewScreen> {
  late TextEditingController _contentTEC;
  late List<TextEditingController> _hashtagTECList;
  late List<Asset> _images;

  @override
  void initState() {
    super.initState();
    _contentTEC = TextEditingController(
        text: context.read<WriteFeedBloc>().state.content ?? '');
    _hashtagTECList = (context.read<WriteFeedBloc>().state.hashtags).isEmpty
        ? [TextEditingController()]
        : context
            .read<WriteFeedBloc>()
            .state
            .hashtags
            .map((e) => TextEditingController(text: e))
            .toList();
    _images = [];
  }

  @override
  void dispose() {
    super.dispose();
    _contentTEC.dispose();
    for (var tec in _hashtagTECList) {
      tec.dispose();
    }
  }

  void _setImages(List<Asset> images) => setState(() {
        _images = images;
      });

  /// 피드 업로드
  void _handleUploadFeed() {
    // 본문과 이미지 둘다 업로드 입력하지 않은 경우, snack bar 보여주기
    if (_contentTEC.text.trim().isEmpty && _images.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('본문이나 이미지를 업로드 해주세요~!'),
        duration: Duration(seconds: 2),
      ));
      return;
    }
    try {
      // Submit Feed 이벤트 발생
      context.read<WriteFeedBloc>().add(SubmitFeedEvent(
          content: _contentTEC.text.trim(),
          images: _images,
          // hashtag 증복제거
          hashtags: _hashtagTECList
              .map((e) => e.text.trim())
              .where((text) => text.isNotEmpty)
              .toSet()
              .toList()));
    } catch (err) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Upload",
              style: GoogleFonts.lobsterTwo(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary)),
          actions: [
            IconButton(
                onPressed: _handleUploadFeed,
                icon: Icon(
                  Icons.upload_outlined,
                  color: Theme.of(context).colorScheme.primary,
                  size: 30,
                ))
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                ContentTextFieldWidget(_contentTEC),
                const SizedBox(height: 10),
                const Divider(),
                const SizedBox(height: 10),
                SelectImageMenuWidget(images: _images, setImages: _setImages),
                const SizedBox(height: 10),
                CarouselSliderWidget(images: _images, setImages: _setImages),
                const SizedBox(height: 10),
                const Divider(),
                const SizedBox(height: 10),
                HashtagsTextFieldWidget(_hashtagTECList),
                const SizedBox(height: 30)
              ],
            ),
          ),
        ),
      );
}
