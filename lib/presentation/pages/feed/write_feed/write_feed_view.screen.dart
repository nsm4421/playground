import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:my_app/core/utils/logging/custom_logger.dart';

import '../bloc/write_feed.bloc.dart';
import '../bloc/write_feed.event.dart';
import '../component/carousel_slider.widget.dart';

/// Feed 업로드 화면
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
                _ContentTextFieldWidget(_contentTEC),
                const SizedBox(height: 10),
                const Divider(),
                const SizedBox(height: 10),
                _HashtagsTextFieldWidget(_hashtagTECList),
                const SizedBox(height: 10),
                const Divider(),
                const SizedBox(height: 10),
                _SelectImageMenuWidget(images: _images, setImages: _setImages),
                const SizedBox(height: 10),
                CarouselSliderWidget(images: _images, setImages: _setImages),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      );
}

/// 업로드 이미지 선택 위젯
class _SelectImageMenuWidget extends StatelessWidget {
  const _SelectImageMenuWidget(
      {required this.images, required this.setImages, super.key});

  final List<Asset> images;
  final void Function(List<Asset>) setImages;

  /// 이미지 선택하기
  void _handleSelectImage() async {
    try {
      await MultiImagePicker.pickImages(
        maxImages: 5,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: const CupertinoOptions(takePhotoIcon: "이미지 업로드"),
        materialOptions: const MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "이미지 업로드",
          allViewTitle: "All",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      ).then((selected) {
        setImages(selected);
      });
    } catch (err) {
      CustomLogger.logger.e(err);
    }
  }

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text("Images",
                  style: GoogleFonts.lobster(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary)),
              const Spacer(),
              IconButton(
                onPressed: _handleSelectImage,
                icon: Icon(Icons.add_a_photo_outlined,
                    color: Theme.of(context).colorScheme.primary),
              ),
              const SizedBox(width: 10),
            ],
          ),
        ],
      );
}

/// 본문 입력 위젯
class _ContentTextFieldWidget extends StatelessWidget {
  const _ContentTextFieldWidget(this._tec, {super.key});

  final TextEditingController _tec;
  static const int _maxChar = 1000;

  _handleClear() => _tec.clear();

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text("Content",
                  style: GoogleFonts.lobster(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary)),
              const Spacer(),
              IconButton(
                  onPressed: _handleClear, icon: const Icon(Icons.cancel))
            ],
          ),
          const SizedBox(height: 5),
          TextField(
            style: const TextStyle(decorationThickness: 0),
            minLines: 3,
            maxLines: 10,
            maxLength: _maxChar,
            controller: _tec,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                counterStyle: TextStyle(color: Colors.grey)),
          )
        ],
      );
}

/// 해시태그 입력 위젯
class _HashtagsTextFieldWidget extends StatefulWidget {
  const _HashtagsTextFieldWidget(this._tecList, {super.key});

  final List<TextEditingController> _tecList;

  @override
  State<_HashtagsTextFieldWidget> createState() =>
      _HashtagsTextFieldWidgetState();
}

class _HashtagsTextFieldWidgetState extends State<_HashtagsTextFieldWidget> {
  static const int _maxChar = 15;

  static const int _maxHashtag = 5;

  void _handleAddHashtag() {
    if (widget._tecList.length < _maxHashtag) {
      setState(() {
        widget._tecList.add(TextEditingController());
      });
    }
  }

  _handleDeleteHashtag(int index) => () => setState(() {
        widget._tecList.removeAt(index);
      });

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text("Hashtag",
                  style: GoogleFonts.lobster(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary)),
              const Spacer(),
              if (widget._tecList.length < _maxHashtag)
                IconButton(
                    onPressed: _handleAddHashtag,
                    icon: Icon(Icons.add_box,
                        color: Theme.of(context).colorScheme.primary)),
            ],
          ),
          const SizedBox(height: 10),
          ...widget._tecList
              .asMap()
              .entries
              .map((entry) => TextField(
                    style: const TextStyle(decorationThickness: 0),
                    maxLines: 1,
                    maxLength: _maxChar,
                    controller: entry.value,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.tag,
                            color: Theme.of(context).colorScheme.primary),
                        suffixIcon: IconButton(
                            onPressed: _handleDeleteHashtag(entry.key),
                            icon: const Icon(Icons.delete, color: Colors.grey)),
                        border: const OutlineInputBorder(),
                        counterStyle: const TextStyle(color: Colors.grey)),
                  ))
              .toList()
        ],
      );
}
