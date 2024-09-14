import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class ImagePreviewWidget extends StatefulWidget {
  const ImagePreviewWidget(this.asset,
      {super.key, this.size = 200, this.quality = 80});

  final AssetEntity asset;
  final int size;
  final int quality;

  @override
  State<ImagePreviewWidget> createState() => _ImagePreviewWidgetState();
}

class _ImagePreviewWidgetState extends State<ImagePreviewWidget> {
  Uint8List? _imageData;

  @override
  initState() {
    super.initState();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _loadImage();
    });
  }

  Future<void> _loadImage() async {
    final data = await widget.asset.thumbnailDataWithSize(
      ThumbnailSize(widget.size, widget.size),
      quality: widget.quality,
    );
    setState(() {
      _imageData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_imageData != null) {
      return Image.memory(
        _imageData!,
        fit: BoxFit.cover,
      );
    }
    return const Center(child: CircularProgressIndicator());
  }
}
