part of '../export.core.dart';

mixin class ImageUtil {
  final _imagePicker = ImagePicker();

  ImagePicker get picker => _imagePicker;

  onSelectMultiImage(Future<void> Function(Iterable<XFile>) cb,
      {int? imageQuality, int compressQuality = 80, int? limit}) async {
    try {
      final selected = await _imagePicker.pickMultiImage(
          imageQuality: imageQuality ?? 80, limit: limit);
      if (selected.isEmpty) {
        return;
      }
      final List<XFile> images = [];
      for (final file in selected) {
        final image = await _compressImage(file, quality: compressQuality);
        images.add(image!);
      }
      await cb(images);
    } catch (error) {
      log(error.toString());
    }
  }

  Future<XFile?> _compressImage(XFile xFile, {int quality = 80}) async {
    final String filePath = xFile.path;
    final String targetPath = path.join((await getTemporaryDirectory()).path,
        '${DateTime.now().millisecondsSinceEpoch}.jpg');
    return await FlutterImageCompress.compressAndGetFile(filePath, targetPath,
        quality: quality, format: CompressFormat.jpeg);
  }
}
