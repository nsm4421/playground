import 'dart:typed_data';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class ImageUtil {
  static Future<List<Uint8List>> getImageData(List<Asset> assets,
          {int quality = 96}) async =>
      await Future.wait(assets.map((image) async => await image
          .getByteData()
          .then((byte) => byte.buffer.asUint8List())
          .then((data) async => await FlutterImageCompress.compressWithList(
              data,
              quality: quality))));
}
