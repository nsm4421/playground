part of 'index.dart';

class ReelsItemWidget extends StatefulWidget {
  const ReelsItemWidget(this.reels, {super.key});

  final ReelsEntity reels;

  @override
  State<ReelsItemWidget> createState() => _ReelsItemWidgetState();
}

class _ReelsItemWidgetState extends State<ReelsItemWidget> {
  static const double _iconSize = 35;

  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(Assets.video.test1)
      ..initialize().then(
        (value) {
          setState(
            () {
              _controller
                ..setLooping(true)
                ..play();
            },
          );
        },
      );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  _handleLike() {}

  _handleComment() {}

  _handleDM() {}

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// 동영상
        Positioned.fill(child: VideoPlayer(_controller)),

        /// 캡션
        if (widget.reels.caption != null)
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.only(
                  bottom: 20, right: _iconSize + 50, left: 12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    CustomPalette.black.withOpacity(0.7),
                  ],
                ),
              ),
              child: Text(
                widget.reels.caption!,
                maxLines: 3,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: CustomPalette.white,
                  overflow: TextOverflow.ellipsis,
                ),
                textAlign: TextAlign.start,
              ),
            ),
          ),

        /// 아이콘
        Positioned(
          right: 12,
          bottom: 20,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CachedCircularImageWidget(
                  widget.reels.author.avatarUrl,
                  radius: (_iconSize + 10) / 2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: IconButton(
                  onPressed: _handleLike,
                  icon: const Icon(
                    Icons.favorite_border,
                    color: CustomPalette.white,
                    size: _iconSize,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: IconButton(
                  onPressed: _handleComment,
                  icon: const Icon(
                    Icons.chat_bubble_outline,
                    color: CustomPalette.white,
                    size: _iconSize,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: IconButton(
                  onPressed: _handleDM,
                  icon: Transform.rotate(
                    angle: -0.45,
                    child: const Icon(
                      Icons.send_outlined,
                      color: CustomPalette.white,
                      size: _iconSize,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
