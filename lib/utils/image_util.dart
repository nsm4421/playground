import 'dart:typed_data';

import 'package:flutter_image_compress/flutter_image_compress.dart';

class ImageUtils {
  static String imageFileName(XFile xFile) {
    final prefix = DateTime.now().millisecondsSinceEpoch.toString();
    return "${prefix}_${xFile.name}";
  }

  static Future<Uint8List> imageCompress(
          {required Uint8List img, int? quality}) async =>
      await FlutterImageCompress.compressWithList(img, quality: quality ?? 50);
}
