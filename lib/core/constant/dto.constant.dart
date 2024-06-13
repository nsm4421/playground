import 'dart:io';

enum LikeType {
  feed("FEED"),
  feedComment("FEED_COMMENT");

  final String name;

  const LikeType(this.name);
}

enum ChatMessageType {
  text,
  image,
  video;
}

enum MediaType {
  image,
  video;
}

extension FileExtension on File {
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
