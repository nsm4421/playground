import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:carousel_slider/carousel_slider.dart';

class PhotoFragment extends StatefulWidget {
  const PhotoFragment(
      {super.key, required this.assets, required this.setAssets});

  final List<Asset> assets;
  final void Function(List<Asset>) setAssets;

  @override
  State<PhotoFragment> createState() => _PhotoFragmentState();
}

class _PhotoFragmentState extends State<PhotoFragment> {
  static const int _maxImages = 5;

  _handleSelectImages() async => widget.setAssets(
        await MultiImagePicker.pickImages(
          maxImages: _maxImages,
          selectedAssets: widget.assets,
          enableCamera: true,
          cupertinoOptions: const CupertinoOptions(takePhotoIcon: "Feed Image"),
          materialOptions: const MaterialOptions(
            actionBarTitle: "Karma",
            allViewTitle: "All",
            useDetailsView: false,
          ),
        ),
      );

  _handleClearImages() => widget.setAssets([]);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Photo",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: Theme.of(context).colorScheme.primary)),
                const Spacer(),
                IconButton(
                    onPressed: _handleClearImages,
                    icon: const Icon(Icons.clear))
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: widget.assets.isEmpty
                  ? ElevatedButton(
                      onPressed: _handleSelectImages,
                      child: Text(
                        "Select Photos",
                        style: Theme.of(context).textTheme.titleMedium,
                      ))
                  : CarouselSlider(
                      options: CarouselOptions(
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 2),
                          pageSnapping: true,
                          height: MediaQuery.of(context).size.width,
                          enableInfiniteScroll: false,
                          enlargeCenterPage: true,
                          enlargeStrategy: CenterPageEnlargeStrategy.zoom),
                      items: widget.assets
                          .map(
                            (asset) => Center(
                              child: AssetThumb(
                                width:
                                    MediaQuery.of(context).size.width.floor(),
                                height:
                                    MediaQuery.of(context).size.width.floor(),
                                asset: asset,
                              ),
                            ),
                          )
                          .toList(),
                    ),
            )
          ],
        ),
      );
}
