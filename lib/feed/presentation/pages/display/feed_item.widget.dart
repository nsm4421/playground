part of 'feed.page.dart';

class FeedItemWidget extends StatefulWidget {
  const FeedItemWidget(this._feed,
      {super.key, required CustomTimeFormat timeFormatter})
      : _timeFormatter = timeFormatter;

  final FeedEntity _feed;
  final CustomTimeFormat _timeFormatter;

  @override
  State<FeedItemWidget> createState() => _FeedItemWidgetState();
}

class _FeedItemWidgetState extends State<FeedItemWidget>
    with SingleTickerProviderStateMixin // 애니메이션을 사용하기 위해 mixin을 추가
{
  bool _isAnimating = false; // 애니메이션 실행중 여부
  late AnimationController _animationController;
  late Animation<double> _animationScale;
  late bool _isMyFeed;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(
          milliseconds: const Duration(milliseconds: 500).inMilliseconds ~/ 2),
    );
    // 처음엔 1배, 나중엔 1.2배 크기로 보여줌
    _animationScale =
        Tween<double>(begin: 1, end: 1.2).animate(_animationController);
    _isMyFeed = context.read<AuthenticationBloc>().currentUser?.id ==
        widget._feed.author?.uid;
  }

  @override
  dispose() {
    super.dispose();
    // 메모리 누수를 막기 위해 dispose
    _animationController.dispose();
  }

  _likeIconAnimation() async {
    // 내가 작성한 게시글이거나, 로딩중이거나 오류인 경우 종료
    if (_isMyFeed ||
        context.read<DisplayFeedBloc>().state.status == Status.loading ||
        context.read<DisplayFeedBloc>().state.status == Status.error) return;
    // 좋아요 및 좋아요 취소 요청을 먼저 발생시킴
    context.read<DisplayFeedBloc>().add(widget._feed.isLike
        ? CancelLikeOnFeedEvent(widget._feed.id!)
        : LikeOnFeedEvent(widget._feed.id!));
    // 애니메이션 실행 중 여부(_isAnimatingO)을 true로 변경 후, 0.5초 뒤 false로 변경
    setState(() {
      _isAnimating = true;
    });
    Timer(const Duration(milliseconds: 500), () {
      setState(() {
        _isAnimating = false;
      });
    });
    // 애니메이션 실행(아이콘 크기를 1배 -> 1.2배로 확대)
    await _animationController.forward();
    await _animationController.reverse();
    // throttle 0.2초
    await Future.delayed(const Duration(milliseconds: 200));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: CustomSpacing.tiny, vertical: CustomSpacing.sm),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircularAvatarImageWidget(widget._feed.author!.avatarUrl!,
                  radius: 30),
              CustomWidth.sm,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget._feed.author!.username!,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary)),
                  CustomHeight.sm,
                  // 작성시간 formatting
                  Text(
                      widget._timeFormatter
                          .timeAgo(widget._feed.createdAt!.toString()),
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: Theme.of(context).colorScheme.primary)),
                ],
              ),
              const Spacer(),
              // 더보기 아이콘
              MoreIconWidget(feed: widget._feed, isMyFeed: _isMyFeed)
            ],
          ),
        ),

        // 이미지
        GestureDetector(
          onDoubleTap: _likeIconAnimation,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(vertical: CustomSpacing.md),
                  decoration: BoxDecoration(
                      color: Colors.blueGrey[100],
                      image: DecorationImage(
                          image:
                              CachedNetworkImageProvider(widget._feed.media!),
                          fit: BoxFit.fitHeight),
                      borderRadius: BorderRadius.circular(CustomSpacing.md))),
              // 좋아요
              if (!_isMyFeed)
                ScaleTransition(
                    scale: _animationScale,
                    child: AnimatedOpacity(
                        opacity: _isAnimating ? 1 : 0,
                        duration: const Duration(microseconds: 500),
                        child: widget._feed.isLike
                            ? const Icon(Icons.favorite,
                                size: 100, color: Colors.red)
                            : const Icon(Icons.heart_broken_outlined,
                                size: 100, color: Colors.blueGrey)))
            ],
          ),
        ),

        // 캡션
        Padding(
            padding: EdgeInsets.symmetric(
                horizontal: CustomSpacing.sm, vertical: CustomSpacing.tiny),
            child: SizedBox(
                child: Text(widget._feed.caption!,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary),
                    overflow: TextOverflow.ellipsis,
                    softWrap: true))),

        // 해시태그
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: CustomSpacing.sm, vertical: CustomSpacing.tiny),
          child: Wrap(
            children: widget._feed.hashtags!
                .map((text) => Container(
                      margin: EdgeInsets.only(
                          right: CustomSpacing.lg, top: CustomSpacing.tiny),
                      padding: EdgeInsets.symmetric(
                          horizontal: CustomSpacing.sm,
                          vertical: CustomSpacing.tiny),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(CustomSpacing.sm),
                          color:
                              Theme.of(context).colorScheme.tertiaryContainer),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.tag,
                                color: Theme.of(context).colorScheme.onPrimary),
                            CustomWidth.tiny,
                            Text(
                              text,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary),
                            )
                          ]),
                    ))
                .toList(),
          ),
        ),

        // 좋아요, 댓글 아이콘 버튼
        IconMenuWidget(feed: widget._feed, isMyFeed: _isMyFeed),

        // 최신댓글
        if (widget._feed.latestComment != null)
          Padding(
              padding: EdgeInsets.symmetric(
                  vertical: CustomSpacing.md, horizontal: CustomSpacing.lg),
              child: Row(
                children: [
                  Text(
                    widget._feed.latestComment!.content!,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.tertiary),
                  ),
                  const Spacer(),
                  Text(
                    widget._timeFormatter.timeAgo(
                        widget._feed.latestComment!.createdAt!.toString()),
                    softWrap: true,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.tertiary),
                  ),
                ],
              )),

        // 디바이더
        Padding(
          padding:
              EdgeInsets.only(top: CustomSpacing.md, bottom: CustomSpacing.lg),
          child: Divider(indent: CustomSpacing.md, endIndent: CustomSpacing.md),
        )
      ],
    );
  }
}
