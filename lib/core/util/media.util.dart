part of 'util.dart';

mixin class CustomMediaUtil {
  final ImagePicker _imagePicker = ImagePicker();

  Future<File?> pickImageAndReturnCompressedImage(
      {ImageSource source = ImageSource.gallery,
      String? filename,
      int quality = 80}) async {
    final selected = await _imagePicker.pickImage(source: source);
    if (selected == null) return null;
    final dir = await getTemporaryDirectory();
    return await FlutterImageCompress.compressAndGetFile(
      selected.path,
      path.join(dir.path, filename ?? '${{const Uuid().v4()}}.jpg'),
      quality: quality,
    ).then((res) => File(res!.path));
  }
}
