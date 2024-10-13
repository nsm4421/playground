part of 'widgets.dart';

class NetworkVideoPlayerWidget extends StatelessWidget {
  const NetworkVideoPlayerWidget(this._videoUrl, {super.key});

  final String _videoUrl;

  @override
  Widget build(BuildContext context) {
    return _VideoPlayerWidget(videoUrl: _videoUrl);
  }
}

class AssetVideoPlayerWidget extends StatelessWidget {
  const AssetVideoPlayerWidget(this._assetPath, {super.key});

  final String _assetPath;

  @override
  Widget build(BuildContext context) {
    return _VideoPlayerWidget(assetPath: _assetPath);
  }
}

class _VideoPlayerWidget extends StatefulWidget {
  const _VideoPlayerWidget({this.assetPath, this.videoUrl});

  final String? assetPath;
  final String? videoUrl;

  @override
  State<_VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<_VideoPlayerWidget> {
  late VideoPlayerController _videoController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    assert((widget.assetPath != null) || (widget.videoUrl != null));
    _videoController = (widget.assetPath == null
        ? VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl!))
        : VideoPlayerController.asset(widget.assetPath!))
      ..initialize();
    _chewieController = ChewieController(
        videoPlayerController: _videoController,
        autoPlay: true,
        looping: true,
        aspectRatio: _videoController.value.aspectRatio,
        allowFullScreen: true);
  }

  @override
  void dispose() {
    _videoController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Chewie(controller: _chewieController);
  }
}
