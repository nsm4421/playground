import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

import '../../../../core/utils/logging/custom_logger.dart';

class SelectImageMenuWidget extends StatelessWidget {
  const SelectImageMenuWidget(
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
