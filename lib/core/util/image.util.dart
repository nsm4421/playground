import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:hot_place/core/error/custom_exception.dart';
import 'package:hot_place/core/error/failure.constant.dart';

class ImageUtil {
  static Future<File> compressImage(File image,
      {int minHeight = 800, int minWidth = 800, int quality = 80}) async {
    final Uint8List? compressedBytes =
        await FlutterImageCompress.compressWithFile(
      image.path,
      minHeight: minHeight,
      minWidth: minWidth,
      quality: quality,
    );
    if (compressedBytes == null) {
      throw CustomException(
          code: ErrorCode.internalError, message: '이미지 압축 중 에러 발생');
    }
    File compressedImage = File('${image.path}_compressed.jpg');
    return await compressedImage.writeAsBytes(compressedBytes);
  }

  static Future<File?> downloadImage(String url) async {
    final res = await Dio()
        .get(url, options: Options(responseType: ResponseType.bytes));
    if (res.statusCode != 200) {
      return null;
    }
    final tempDir = await Directory.systemTemp.createTemp();
    File file = File('${tempDir.path}/profile-image.jpg');
    await file.writeAsBytes(res.data);
    return file;
  }
}
