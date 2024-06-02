import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:my_app/presentation/components/video_preview/video.widget.dart';
import 'package:video_player/video_player.dart';

class VideoPreviewForUploadWidget extends StatefulWidget {
  const VideoPreviewForUploadWidget(
      {super.key, required this.setVideo, required this.width, this.height});

  final void Function(File? video) setVideo;
  final double width;
  final double? height;

  @override
  State<VideoPreviewForUploadWidget> createState() =>
      _VideoPreviewForUploadWidgetState();
}

class _VideoPreviewForUploadWidgetState
    extends State<VideoPreviewForUploadWidget> {
  VideoPlayerController? _controller;
  Duration? _totalDuration;

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
      _controller = VideoPlayerController.file(file)
        ..initialize().then((_) {
          setState(() {
            _controller!.play();
            _totalDuration = _controller!.value.duration;
          });
        });
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
        child: _controller == null || _totalDuration == null
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
            : Stack(children: [
                // 비디오 재생
                VideoWidget(
                    controller: _controller!, totalDuration: _totalDuration!),

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
              ]));
  }
}
