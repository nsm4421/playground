import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoWidget extends StatefulWidget {
  const VideoWidget({
    super.key,
    required VideoPlayerController controller,
    required Duration totalDuration,
    double? width,
    double? height,
  })  : _controller = controller,
        _totalDuration = totalDuration,
        _width = width,
        _height = height;
  final VideoPlayerController _controller;
  final Duration _totalDuration;
  final double? _width;
  final double? _height;

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late Duration _currentTime;
  static const double _slideBarHeight = 10;
  bool _isPlaying = true;

  void _handlePlaying() {
    _isPlaying = !_isPlaying;
    if (_isPlaying) {
      widget._controller.play();
    } else {
      widget._controller.pause();
    }
  }

  @override
  void initState() {
    super.initState();
    _currentTime = Duration.zero;
    widget._controller.addListener(() {
      setState(() {
        _currentTime = widget._controller.value.position;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.black12),
      width: widget._width ?? MediaQuery.of(context).size.width,
      height: widget._height,
      child: Stack(
        children: [
          // 영상
          Padding(
            padding: const EdgeInsets.only(bottom: _slideBarHeight),
            child: AspectRatio(
              aspectRatio: widget._controller.value.aspectRatio,
              child: VideoPlayer(widget._controller),
            ),
          ),

          // 배경색
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

          // 영상 시청시간 진행표
          Positioned(
            bottom: 0,
            left: 0,
            child: Slider(
              value: _currentTime.inSeconds.toDouble(),
              max: widget._totalDuration.inSeconds.toDouble(),
              onChanged: (value) {
                widget._controller.seekTo(Duration(seconds: value.toInt()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
