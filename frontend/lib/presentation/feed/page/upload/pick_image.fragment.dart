import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/util/toast.util.dart';

class PickImageFragment extends StatefulWidget {
  const PickImageFragment(
      {super.key,
      required ImagePicker imagePicker,
      required List<File> images,
      required void Function(List<File> images) handleSetImages})
      : _imagePicker = imagePicker,
        _images = images,
        _handleSetImages = handleSetImages;

  final ImagePicker _imagePicker;
  final List<File> _images;
  final void Function(List<File> images) _handleSetImages;

  @override
  State<PickImageFragment> createState() => _PickImageFragmentState();
}

class _PickImageFragmentState extends State<PickImageFragment> {
  static const _maxImageCount = 3;

  late PageController _pageController;

  int _currentIndex = 0;

  @override
  initState() {
    super.initState();
    _pageController = PageController();
    _pageController.addListener(() {
      setState(() {
        _currentIndex = (_pageController.page!).round();
      });
    });
  }

  @override
  dispose() {
    super.dispose();
    _pageController.dispose();
  }

  _handleUnPickImage() {
    List<File> images = [...widget._images];
    images.removeAt(_currentIndex);
    widget._handleSetImages(images);
  }

  _handlePickImages() async =>
      await widget._imagePicker.pickMultiImage().then((assets) {
        // 최대 3개의 이미지 선택 가능
        if (assets.length > _maxImageCount) {
          assets = assets.sublist(0, _maxImageCount);
          ToastUtil.toast('최대 $_maxImageCount개의 이미지를 선택할 수 있습니다');
        }
        final images = assets
            .map((asset) => asset.path)
            .map((path) => File(path))
            .toList();
        widget._handleSetImages(images);
      });

  @override
  Widget build(BuildContext context) => widget._images.isEmpty
      // 선택한 이미지가 없는 경우
      ? SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width / 2,
          child: Align(
              alignment: Alignment.center,
              child: InkWell(
                  onTap: _handlePickImages,
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Row(mainAxisSize: MainAxisSize.min, children: [
                      Icon(Icons.add_a_photo_outlined,
                          size: 30,
                          color: Theme.of(context).colorScheme.primary),
                      const SizedBox(width: 10),
                      Text("Photo",
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.copyWith(
                                  color: Theme.of(context).colorScheme.primary))
                    ]),
                    const SizedBox(height: 10),
                    Text("최대 3개의 사진을 업로드할 수 있어요",
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: Theme.of(context).colorScheme.tertiary))
                  ]))),
        )
      // 선택한 이미지가 있는 경우
      : SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,
          child: Stack(children: [
            // Carousel
            PageView.builder(
                controller: _pageController,
                itemCount: widget._images.length,
                itemBuilder: (_, index) {
                  return Image.file(widget._images[index], fit: BoxFit.cover);
                }),
            // 페이지 번호
            Positioned(
                bottom: 5,
                right: 5,
                child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color:
                            Theme.of(context).colorScheme.secondaryContainer),
                    child: Text("${_currentIndex + 1}/${widget._images.length}",
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSecondaryContainer)))),
            Positioned(
                top: 5,
                right: 5,
                child: IconButton(
                  onPressed: _handleUnPickImage,
                  icon: const Icon(Icons.clear),
                ))
          ]),
        );
}
