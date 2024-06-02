import 'package:flutter/material.dart';
import 'package:my_app/data/entity/short/short.entity.dart';
import 'package:my_app/presentation/components/video_preview/video.widget.dart';
import 'package:video_player/video_player.dart';

class VideoPreviewItemWidget extends StatefulWidget {
  const VideoPreviewItemWidget(this.short,
      {super.key, this.width, this.height});

  final ShortEntity short;
  final double? width;
  final double? height;

  @override
  State<VideoPreviewItemWidget> createState() => _VideoPreviewItemWidgetState();
}

class _VideoPreviewItemWidgetState extends State<VideoPreviewItemWidget> {
  bool _isPlaying = true;
  late VideoPlayerController _controller;
  Duration _totalDuration = Duration.zero;

  @override
  void initState() {
    super.initState();
    _controller =
        VideoPlayerController.networkUrl(Uri.parse(widget.short.shortUrl!))
          ..initialize().then((_) {
            setState(() {
              _controller.play();
              _totalDuration = _controller.value.duration;
            });
          });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _handlePlaying() {
    _isPlaying = !_isPlaying;
    if (_isPlaying) {
      _controller.play();
    } else {
      _controller.pause();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: widget.width,
        height: widget.height,
        child: Stack(
          children: [
            VideoWidget(controller: _controller, totalDuration: _totalDuration),
            Positioned.fill(
              child: GestureDetector(
                onTap: _handlePlaying,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.center,
                      colors: [
                        Colors.black.withOpacity(0.5),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
