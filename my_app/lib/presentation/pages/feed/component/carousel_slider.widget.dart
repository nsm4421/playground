import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class CarouselSliderWidget extends StatelessWidget {
  const CarouselSliderWidget(
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
