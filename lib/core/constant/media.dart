import 'package:image_picker/image_picker.dart';

enum MediaType {
  image,
  video;
}

extension XFileExtension on XFile {
  MediaType mediaType() {
    String fileExtension = path.split('.').last.toLowerCase();
    if (['jpg', 'jpeg', 'png', 'gif'].contains(fileExtension)) {
      return MediaType.image;
    } else if (['mp4', 'mov', 'avi', 'mkv'].contains(fileExtension)) {
      return MediaType.video;
    } else {
      throw FormatException('file extension is given by $fileExtension');
    }
  }
}
