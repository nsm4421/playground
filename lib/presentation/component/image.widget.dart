import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class SquareImageWidget extends StatelessWidget {
  const SquareImageWidget(this.xFile, {super.key, this.size});

  final XFile xFile;
  final double? size;

  @override
  Widget build(BuildContext context) => SizedBox(
      width: size ?? MediaQuery.of(context).size.width,
      height: size ?? MediaQuery.of(context).size.width,
      child: Image.file(
        File(xFile.path),
        fit: BoxFit.cover,
      ));
}

class CircleImageWidget extends StatelessWidget {
  const CircleImageWidget(this.xFile, {super.key, this.size});

  final XFile xFile;
  final double? size;

  @override
  Widget build(BuildContext context) => Container(
      width: size ?? MediaQuery.of(context).size.width,
      height: size ?? MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              fit: BoxFit.cover, image: FileImage(File(xFile.path)))));
}
