import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PhotoItemWidget extends StatelessWidget {
  const PhotoItemWidget({super.key, required this.xFile});

  final XFile xFile;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.file(
              File(xFile.path),
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
