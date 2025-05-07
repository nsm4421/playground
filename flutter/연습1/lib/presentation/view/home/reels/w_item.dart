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
    _controller =
        VideoPlayerController.networkUrl(Uri.parse(widget.reels.video))
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

  _handleTap() async {
    log('reels tapped|current:${_controller.value.isPlaying}');
    if (!_controller.value.isInitialized) {
      return;
    } else if (_controller.value.isPlaying) {
      await _controller.pause();
    } else {
      await _controller.play();
    }
    setState(() {});
  }

  _handleComment() {}

  _handleDM() {}

  _handleNavigateToCreatePage() async {
    context.read<HomeBottomNavCubit>().switchVisible(false);
    await context.push(Routes.createReels.path).whenComplete(() {
      context.read<HomeBottomNavCubit>().switchVisible(true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Stack(
        children: [
          /// 동영상
          Positioned.fill(child: VideoPlayer(_controller)),

          /// 일시정지 아이콘
          if (!_controller.value.isPlaying)
            const Align(
              alignment: Alignment.center,
              child: ShadowedIconButton(
                iconData: Icons.pause,
                iconColor: CustomPalette.lightGrey,
                iconSize: 50,
              ),
            ),

          /// 캡션
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              alignment: Alignment.bottomLeft,
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
                widget.reels.caption,
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
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: CachedCircularImageWidget(
                    widget.reels.author.avatarUrl,
                    radius: (_iconSize + 10) / 2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: LikeButtonWidget(
                    widget.reels,
                    iconSize: _iconSize,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: ShadowedIconButton(
                    onTap: _handleComment,
                    iconData: Icons.chat_bubble_outline,
                    iconSize: _iconSize,
                    iconColor: CustomPalette.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: ShadowedIconButton(
                    angle: -0.45,
                    onTap: _handleDM,
                    iconData: Icons.send_outlined,
                    iconSize: _iconSize,
                    iconColor: CustomPalette.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: ShadowedIconButton(
                    onTap: _handleNavigateToCreatePage,
                    iconData: Icons.add_circle_outline,
                    iconSize: _iconSize,
                    iconColor: CustomPalette.white,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
