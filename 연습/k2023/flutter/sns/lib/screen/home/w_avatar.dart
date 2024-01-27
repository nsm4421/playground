import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MainStoryAvatarWidget extends StatelessWidget {
  final String imagePath;
  final double size;

  const MainStoryAvatarWidget(
      {super.key, required this.imagePath, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration:
          const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size),
        child: SizedBox(
          width: size,
          height: size,
          child: CachedNetworkImage(imageUrl: imagePath, fit: BoxFit.cover),
        ),
      ),
    );
  }
}

class StoryAvatarWidget extends StatelessWidget {
  final String imagePath;
  final double size;
  final double? padding;
  final double? margin;

  const StoryAvatarWidget(
      {super.key,
      required this.imagePath,
      required this.size,
      this.padding = 5,
      this.margin = 2});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding!),
      margin: EdgeInsets.symmetric(horizontal: margin!),
      decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.purple, Colors.orange])),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size),
        child: SizedBox(
            width: size,
            height: size,
            child: CachedNetworkImage(imageUrl: imagePath, fit: BoxFit.cover)),
      ),
    );
  }
}
