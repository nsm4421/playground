part of 'index.dart';

class FeedItemWidget extends StatefulWidget {
  const FeedItemWidget(this.feed, {super.key});

  final FeedEntity feed;

  @override
  State<FeedItemWidget> createState() => _FeedItemWidgetState();
}

class _FeedItemWidgetState extends State<FeedItemWidget> {
  late PageController _controller;
  late int _currentIndex;

  static final Duration _duration = 300.ms;

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    _controller = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  _handlePageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  _handleJump(int index) async {
    await _controller.animateToPage(index,
        duration: _duration, curve: Curves.bounceIn);
  }

  _handleShowDetail() async {
    context.read<HomeBottomNavCubit>().switchVisible(false);
    await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return FeedDetailScreen(widget.feed);
        }).whenComplete(() {
      context.read<HomeBottomNavCubit>().switchVisible(true);
    });
  }

  _handleShowComment() {}

  _handleShare() {}

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// 헤더
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CachedCircularImageWidget(
                widget.feed.author.avatarUrl,
                radius: 25,
              ),
              (12.0).w,
              Text(
                widget.feed.author.username,
                style: context.textTheme.titleMedium,
                softWrap: true,
              )
            ],
          ),
        ),

        /// 이미지
        GestureDetector(
          onTap: _handleShowDetail,
          child: Stack(
            children: [
              SizedBox(
                height: context.width,
                child: PageView.builder(
                  controller: _controller,
                  itemCount: widget.feed.images.length,
                  onPageChanged: _handlePageChanged,
                  itemBuilder: (item, index) {
                    return CachedSquareImageWidget(
                      widget.feed.images[index],
                    );
                  },
                ),
              ),
              if (widget.feed.images.length > 1)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: CustomPalette.darkGrey,
                    ),
                    child: Text(
                      '${_currentIndex + 1}/${widget.feed.images.length}',
                      style: context.textTheme.labelLarge?.copyWith(
                        color: CustomPalette.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),

        Stack(
          alignment: Alignment.center,
          children: [
            /// Icons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 좋아요 아이콘
                    LikeButtonWidget(widget.feed),

                    // 댓글 아이콘
                    IconButton(
                      onPressed: _handleShowComment,
                      icon: Icon(Icons.chat_bubble_outline),
                    ),
                  ],
                ),

                // 공유 아이콘
                IconButton(
                  onPressed: _handleShare,
                  icon: const Icon(Icons.share),
                )
              ],
            ),

            /// indicator
            if (widget.feed.images.length >= 2)
              SmoothPageIndicator(
                controller: _controller,
                count: widget.feed.images.length,
                onDotClicked: _handleJump,
                effect: SlideEffect(
                    spacing: 8,
                    dotWidth: 12,
                    dotHeight: 13,
                    paintStyle: PaintingStyle.stroke,
                    strokeWidth: 1.5,
                    dotColor: CustomPalette.lightGrey,
                    activeDotColor: context.colorScheme.primary),
              ),
          ],
        ),
      ],
    );
  }
}
