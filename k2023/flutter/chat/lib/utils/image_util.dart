import 'dart:typed_data';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

class ImageUtils {
  static Future<XFile?> selectImageFromGallery() async {
    final ImagePicker imagePicker = ImagePicker();
    return await imagePicker.pickImage(source: ImageSource.gallery);
  }

  static String imageFileName(XFile xFile) {
    final prefix = DateTime.now().millisecondsSinceEpoch.toString();
    return "${prefix}_${xFile.name}";
  }

  static Future<Uint8List> imageCompress(
          {required Uint8List img, int? quality}) async =>
      await FlutterImageCompress.compressWithList(img, quality: quality ?? 50);
}
