import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:my_app/core/utils/logging/custom_logger.dart';

class ProfileImageFragment extends StatefulWidget {
  const ProfileImageFragment({super.key});

  @override
  State<ProfileImageFragment> createState() => _ProfileImageFragmentState();
}

class _ProfileImageFragmentState extends State<ProfileImageFragment> {
  static const int _maxImages = 5;

  List<Asset> images = <Asset>[];

  /// 이미지 선택하기
  _handleSelectImage() async {
    try {
      final List<Asset> temp = await MultiImagePicker.pickImages(
        maxImages: _maxImages,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: const CupertinoOptions(takePhotoIcon: "프사"),
        materialOptions: const MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "프사",
          allViewTitle: "All",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
      setState(() {
        images = temp;
      });
    } catch (err) {
      CustomLogger.logger.e(err);
    }
  }

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 80),
            Text("Profile Image",
                style: GoogleFonts.lobsterTwo(
                    fontSize: 50, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: _handleSelectImage,
                child: Row(
                  children: [
                    Text("잘 나온 사진을 선택해주세요(최대 3개)",
                        style: Theme.of(context).textTheme.bodyMedium),
                    const Spacer(),
                    const Icon(Icons.add_a_photo_outlined),
                  ],
                )),
            const SizedBox(height: 100),
            _CarouselWidget(images)
          ],
        ),
      );
}

class _CarouselWidget extends StatelessWidget {
  const _CarouselWidget(this.images, {super.key});

  final List<Asset> images;

  @override
  Widget build(BuildContext context) => CarouselSlider(
        items: images
            .map((asset) => Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onPrimaryContainer),
                  child: AssetThumb(
                    asset: asset,
                    width: MediaQuery.of(context).size.width.floor(),
                    height: MediaQuery.of(context).size.width.floor(),
                  ),
                ))
            .toList(),
        options: CarouselOptions(
          autoPlay: true,
          autoPlayAnimationDuration: const Duration(seconds: 1),
          enableInfiniteScroll: false,
          enlargeCenterPage: true,
        ),
      );
}
