part of "display_feed.page.dart";

class FeedItemWidget extends StatefulWidget {
  const FeedItemWidget(this._feed, {super.key});

  final FeedEntity _feed;

  @override
  State<FeedItemWidget> createState() => _FeedItemWidgetState();
}

class _FeedItemWidgetState extends State<FeedItemWidget> {
  late bool _isMine;
  late bool _isLike;

  @override
  initState() {
    super.initState();
    _isMine =
        context.read<AuthBloc>().currentUser!.id == widget._feed.createdBy!.id;
    _isLike = widget._feed.emotion != null;
  }

  // 좋아요 처리
  _handleLike() {
    try {
      final status = context.read<DisplayFeedBloc>().state.emotionStatus;
      switch (status) {
        case Status.initial:
        case Status.success:
          context.read<DisplayFeedBloc>().add(_isLike
              ? CancelLikeFeedEvent(
                  feedId: widget._feed.id!,
                  emotionId: widget._feed.emotion!.id!)
              : LikeFeedEvent(widget._feed.id!));
        case Status.loading:
        case Status.error:
          return;
      }
      setState(() {
        _isLike = !_isLike;
      });
    } catch (error) {
      log(error.toString());
    }
  }

  // 댓글 목록 페이지로
  _handleMoveToCommentPage() async {
    await context.push(RoutePaths.feedComment.path, extra: widget._feed);
  }

  // 피드 삭제
  _handleDelete() {
    context.read<DisplayFeedBloc>().add(DeleteFeedEvent(widget._feed.id!));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color:
              Theme.of(context).colorScheme.primaryContainer.withOpacity(0.1)),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          // 헤더
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                // 프로필 사진
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: CircleAvatar(
                      radius: 25,
                      backgroundImage: CachedNetworkImageProvider(
                          widget._feed.createdBy!.profileImage!)),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 닉네임
                    if (widget._feed.createdBy?.nickname != null)
                      Text(widget._feed.createdBy!.nickname!,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold)),
                    // 작성시간
                    if (widget._feed.createdAt != null)
                      Text(widget._feed.createdAt!.format(),
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.tertiary)),
                  ],
                ),
                const Spacer(),
                if (_isMine)
                  IconButton(
                      onPressed: _handleDelete,
                      icon: Icon(
                        Icons.delete_outline_outlined,
                        color: Theme.of(context).colorScheme.tertiary,
                      ))
              ])),

          /// 본문
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Theme.of(context)
                    .colorScheme
                    .primaryContainer
                    .withOpacity(0.5)),
            alignment: Alignment.topLeft,
            child: Text(widget._feed.content!,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.onPrimary),
                softWrap: true),
          ),

          /// 이미지
          if (widget._feed.media.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: DisplayMediaWidget(widget._feed.media,
                  size: MediaQuery.of(context).size.width),
            ),

          /// 해시태그
          if (widget._feed.hashtags.isNotEmpty)
            Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                alignment: Alignment.centerLeft,
                child: HashtagsWidget(widget._feed.hashtags,
                    bgColor: Theme.of(context).colorScheme.secondary)),

          /// 아이콘
          const Divider(indent: 20, endIndent: 20),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // 좋아요 버튼
                  Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: IconButton(
                          onPressed: _handleLike,
                          icon: _isLike
                              ? Icon(
                                  Icons.favorite,
                                  color: Theme.of(context).colorScheme.primary,
                                )
                              : Icon(Icons.favorite_border,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary))),

                  // 댓글 버튼
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: IconButton(
                        onPressed: _handleMoveToCommentPage,
                        icon: Icon(Icons.comment,
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.5))),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
