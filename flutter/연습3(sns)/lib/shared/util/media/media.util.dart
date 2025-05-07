import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

@lazySingleton
class CustomMediaUtil {
  final ImagePicker _imagePicker = ImagePicker();

  Future<File?> pickCompressedImage(
      {String filename = "media.jpg", int quality = 80}) async {
    final selected = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (selected == null) return null;
    final dir = await getTemporaryDirectory();
    return await FlutterImageCompress.compressAndGetFile(
      selected.path,
      path.join(dir.path, filename),
      quality: quality,
    ).then((res) => File(res!.path));
  }
}
