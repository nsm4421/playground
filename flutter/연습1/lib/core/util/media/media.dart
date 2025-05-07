import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class CustomImageUtil {
  static Future<File?> pickImageAndReturnCompressedImage(
      {required ImagePicker imagePicker,
      ImageSource source = ImageSource.gallery,
      required String filename,
      int quality = 80}) async {
    final selected = await imagePicker.pickImage(source: source);
    if (selected == null) return null;
    final dir = await getTemporaryDirectory();
    return await FlutterImageCompress.compressAndGetFile(
      selected.path,
      path.join(dir.path, filename),
      quality: quality,
    ).then((res) => File(res!.path));
  }
}
