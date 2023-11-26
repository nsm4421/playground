import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

import '../../../core/utils/logging/custom_logger.dart';

class WriteFeedScreen extends StatefulWidget {
  const WriteFeedScreen({super.key});

  @override
  State<WriteFeedScreen> createState() => _WriteFeedScreenState();
}

class _WriteFeedScreenState extends State<WriteFeedScreen> {
  late TextEditingController _titleTEC;
  late List<TextEditingController> _hashtagTEC;
  late List<Asset> _images;

  @override
  void initState() {
    super.initState();
    _titleTEC = TextEditingController();
    _hashtagTEC = [TextEditingController()];
    _images = [];
  }

  @override
  void dispose() {
    super.dispose();
    _titleTEC.dispose();
    for (var tec in _hashtagTEC) {
      tec.dispose();
    }
  }

  void _setImages(List<Asset> images) {
    setState(() {
      _images = images;
    });
  }

  // TODO : 업로드 기능개발
  void _handleUploadFeed() {}

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
                _TitleTextField(_titleTEC),
                const SizedBox(height: 10),
                const Divider(),
                const SizedBox(height: 10),
                _SelectImageMenu(images: _images, setImages: _setImages),
                const SizedBox(height: 10),
                _CarouselSlider(images: _images, setImages: _setImages),
                const SizedBox(height: 10),
                const Divider(),
                const SizedBox(height: 10),
                _HashtagsTextField(_hashtagTEC),
                const SizedBox(height: 30)
              ],
            ),
          ),
        ),
      );
}

class _TitleTextField extends StatelessWidget {
  const _TitleTextField(this._tec, {super.key});

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

class _SelectImageMenu extends StatelessWidget {
  const _SelectImageMenu(
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

class _CarouselSlider extends StatelessWidget {
  const _CarouselSlider(
      {super.key, required this.images, required this.setImages});

  final List<Asset> images;
  final void Function(List<Asset>) setImages;

  _handleCancelImage(int index) => () {
        final newImage = [...images];
        newImage.removeAt(index);
        setImages(newImage);
      };

  @override
  Widget build(BuildContext context) => CarouselSlider(
        items: images.isEmpty
            ? [
                Container(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  child: Center(
                    child: Text(
                      "선택된 이미지가 없습니다",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(color: Colors.blueGrey),
                    ),
                  ),
                )
              ]
            : images
                .asMap()
                .entries
                .map(
                  (entry) => Stack(
                    children: [
                      Positioned.fill(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer),
                          child: AssetThumb(
                            spinner: const CircularProgressIndicator(),
                            asset: entry.value,
                            width: MediaQuery.of(context).size.width.floor(),
                            height: MediaQuery.of(context).size.width.floor(),
                          ),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(150, 0, 0, 0),
                              Color.fromARGB(0, 0, 0, 0)
                            ],
                            begin: Alignment.topRight,
                            end: Alignment.topCenter,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: IconButton(
                          onPressed: _handleCancelImage(entry.key),
                          icon: const Icon(Icons.cancel, color: Colors.grey),
                        ),
                      )
                    ],
                  ),
                )
                .toList(),
        options: CarouselOptions(
          autoPlay: true,
          autoPlayAnimationDuration: const Duration(seconds: 2),
          enableInfiniteScroll: false,
          enlargeCenterPage: true,
        ),
      );
}

class _HashtagsTextField extends StatefulWidget {
  const _HashtagsTextField(this._tecList, {super.key});

  final List<TextEditingController> _tecList;

  @override
  State<_HashtagsTextField> createState() => _HashtagsTextFieldState();
}

class _HashtagsTextFieldState extends State<_HashtagsTextField> {
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
