part of 'index.dart';

class FeedDetailWidget extends StatefulWidget {
  const FeedDetailWidget(this.feed, {super.key});

  final FeedEntity feed;

  @override
  State<FeedDetailWidget> createState() => _FeedDetailWidgetState();
}

class _FeedDetailWidgetState extends State<FeedDetailWidget> {
  late PageController _controller;

  static final Duration _duration = 200.ms;

  @override
  initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  dispose() {
    super.dispose();
    _controller.dispose();
  }

  _handlePop() {
    context.pop();
  }

  _handleJump(int index) async {
    await _controller.animateToPage(index,
        duration: _duration, curve: Curves.bounceIn);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            SizedBox(
              height: context.width,
              child: PageView.builder(
                controller: _controller,
                scrollDirection: Axis.horizontal,
                itemCount: widget.feed.images.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      CachedSquareImageWidget(widget.feed.images[index]),
                      if (widget.feed.captions[index].isNotEmpty)
                        Text(
                          widget.feed.captions[index],
                          softWrap: true,
                        )
                    ],
                  );
                },
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).padding.top,
              left: 0,
              child: IconButton(
                icon: const ShadowedIconButton(
                  iconData: Icons.clear,
                ),
                onPressed: _handlePop,
              ),
            )
          ],
        ),

        /// indicator
        if (widget.feed.images.length > 1)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Align(
              alignment: Alignment.center,
              child: SmoothPageIndicator(
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
            ),
          ),

        if (widget.feed.hashtags.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Wrap(
              children: List.generate(
                widget.feed.hashtags.length,
                (index) => Container(
                  margin: const EdgeInsets.only(right: 8, bottom: 8),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  decoration: BoxDecoration(
                    color:
                        context.colorScheme.secondaryContainer.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.tag, color: context.colorScheme.onSecondary),
                      (8.0).w,
                      Text(
                        widget.feed.hashtags[index],
                        style: context.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: context.colorScheme.onSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
      ],
    );
  }
}
