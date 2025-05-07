import 'package:flutter/material.dart';

class ImageIconWidget extends StatelessWidget {
  final String imagePath;
  final double? size;

  const ImageIconWidget(
      {super.key, required this.imagePath, this.size=30});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath,
      width: size,
      height: size,
    );
  }
}
