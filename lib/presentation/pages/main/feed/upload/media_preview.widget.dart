part of 'upload_feed.page.dart';

class MediaPreviewWidget extends StatefulWidget {
  const MediaPreviewWidget(this._file, {super.key});

  final File _file;

  @override
  State<MediaPreviewWidget> createState() => _MediaPreviewWidgetState();
}

class _MediaPreviewWidgetState extends State<MediaPreviewWidget> {
  late File _file;
  late MediaType _type;

  @override
  void initState() {
    super.initState();
    _file = File(widget._file.path);
    _type = widget._file.mediaType();
  }

  @override
  Widget build(BuildContext context) {
    switch (_type) {
      case MediaType.image:
        return _ImagePreview(_file);
      case MediaType.video:
        return _VideoPreview(_file);
      default:
        throw ArgumentError('not supported media type');
    }
  }
}

/// 이미지 미리보기
class _ImagePreview extends StatelessWidget {
  const _ImagePreview(this._image, {super.key});

  final File _image;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Theme.of(context).colorScheme.tertiaryContainer),
        child: Image.file(_image, fit: BoxFit.fitHeight));
  }
}

/// 비디오 미리보기
class _VideoPreview extends StatefulWidget {
  const _VideoPreview(this._file, {super.key});

  final File _file;

  @override
  State<_VideoPreview> createState() => _VideoPreviewState();
}

class _VideoPreviewState extends State<_VideoPreview> {
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.file(widget._file)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _videoPlayerController.value.isInitialized
        ? Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: AspectRatio(
              aspectRatio: _videoPlayerController.value.aspectRatio,
              child: VideoPlayer(_videoPlayerController),
            ),
          )
        : const CircularProgressIndicator();
  }
}
