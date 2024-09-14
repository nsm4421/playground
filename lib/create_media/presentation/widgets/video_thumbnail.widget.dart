import 'package:flutter/material.dart';
import 'package:flutter_app/create_media/presentation/widgets/image_preview.widget.dart';
import 'package:flutter_app/shared/style/size/custom_size.dart';
import 'package:photo_manager/photo_manager.dart';

class VideoThumbnailWidget extends StatefulWidget {
  const VideoThumbnailWidget(this.asset,
      {super.key,
      required this.width,
      required this.height,
      this.quality = 80});

  final AssetEntity asset;
  final double width;
  final double height;
  final int quality;

  @override
  State<VideoThumbnailWidget> createState() => _VideoThumbnailWidgetState();
}

class _VideoThumbnailWidgetState extends State<VideoThumbnailWidget> {
  late final String durationString;

  @override
  void initState() {
    super.initState();
    final duration = widget.asset.videoDuration;
    if (duration.inHours > 0) {
      durationString = '${duration.inHours}시간 ${duration.inMinutes}분';
    } else if (duration.inMinutes > 0) {
      durationString = '${duration.inMinutes}분 ${duration.inSeconds}초';
    } else {
      durationString = '${duration.inSeconds}초';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 썸네일
        SizedBox(
          width: widget.width,
          height: widget.height,
          child: ImagePreviewWidget(widget.asset, quality: widget.quality),
        ),

        // 그라데이션
        Positioned.fill(
            child: Container(
                width: widget.width,
                height: widget.height,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                        colors: [
                      Colors.black.withOpacity(0.7),
                      Colors.transparent,
                    ])))),

        // 동영상 길이
        Positioned(
          right: CustomSpacing.md,
          bottom: CustomSpacing.md,
          child: Text(
            durationString,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: Colors.white),
          ),
        )
      ],
    );
  }
}
