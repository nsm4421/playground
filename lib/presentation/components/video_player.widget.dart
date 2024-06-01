import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget(
      {super.key, required this.setVideo, required this.width, this.height});

  final void Function(File? video) setVideo;
  final double width;
  final double? height;

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  bool _isPlaying = true;
  VideoPlayerController? _controller;

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  Future<void> _handleSelectVideo() async {
    final filePath = await FilePicker.platform
        .pickFiles(
            dialogTitle: "PICK VIDEO",
            allowMultiple: false,
            allowCompression: true,
            type: FileType.video)
        .then((res) => res?.files.first.path);
    // 파일을 선택하지 않은 경우
    if (filePath == null) {
      return;
    }
    // 파일을 선택한 경우
    else {
      final file = File(filePath);
      widget.setVideo(file);
      _isPlaying = true;
      _controller = VideoPlayerController.file(file)
        ..initialize().then((_) {
          setState(() {});
          _controller!.play();
        });
    }
  }

  void _handlePlaying() {
    _isPlaying = !_isPlaying;
    if (_isPlaying) {
      _controller?.play();
    } else {
      _controller?.pause();
    }
  }

  _handleClearVideo() {
    setState(() {
      _controller?.dispose();
      _controller = null;
      widget.setVideo(null);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: _controller == null
          // 비디오를 선택하지 않은 경우
          ? Center(
              child: IconButton(
                  onPressed: _handleSelectVideo,
                  icon: Icon(
                    Icons.video_library_outlined,
                    size: widget.width / 3,
                  )),
            )
          // 비디오를 선택한 경우
          : Stack(
              children: [
                // 비디오 재생
                Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(color: Colors.black12),
                  child: AspectRatio(
                    aspectRatio: _controller!.value.aspectRatio,
                    child: VideoPlayer(_controller!),
                  ),
                ),

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

                // 취소버튼
                Positioned(
                    right: 0,
                    top: 0,
                    child: IconButton(
                        icon: const Icon(
                          Icons.clear,
                          size: 25,
                          color: Colors.white,
                        ),
                        onPressed: _handleClearVideo))
              ],
            ),
    );
  }
}
