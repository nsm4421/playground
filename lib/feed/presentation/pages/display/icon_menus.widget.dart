part of 'feed.page.dart';

class IconMenuWidget extends StatefulWidget {
  const IconMenuWidget(
      {super.key, required FeedEntity feed, bool isMyFeed = false})
      : _feed = feed,
        _isMyFeed = isMyFeed;

  final FeedEntity _feed;
  final bool _isMyFeed;

  @override
  State<IconMenuWidget> createState() => _IconMenuWidgetState();
}

class _IconMenuWidgetState extends State<IconMenuWidget> {
  bool _isDmLoading = false; // DM기능 로딩중 여부

  bool get _isReady =>
      context.read<DisplayFeedBloc>().state.status != Status.loading &&
      context.read<DisplayFeedBloc>().state.status != Status.error;

  _handleLike() async {
    if (widget._isMyFeed || !_isReady) return;
    try {
      context.read<DisplayFeedBloc>().add(widget._feed.isLike
          ? CancelLikeOnFeedEvent(widget._feed.id!)
          : LikeOnFeedEvent(widget._feed.id!));
    } catch (error) {
      log('좋아요 요청 오류 : ${error.toString()}');
    }
  }

  _sendDM() async {
    if (_isDmLoading) return;
    try {
      _isDmLoading = true;
      await context
          .read<ChatBloc>()
          .findChatByUid(widget._feed.author!.uid!)
          .then((chat) {
        if (chat == null) throw Exception('DM요청 실패');
        context.push(RoutePaths.chatRoom.path, extra: chat);
      });
    } catch (error) {
      log('dm 기능 오류');
      getIt<CustomSnakbar>().error(title: 'DM요청 실패');
    } finally {
      _isDmLoading = false;
    }
  }

  _handleComment() async {
    await showModalBottomSheet(
        showDragHandle: false,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        isScrollControlled: false,
        elevation: 0,
        context: context,
        builder: (_) => CommentPage(widget._feed.id!));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DisplayFeedBloc, DisplayFeedState>(
        builder: (context, state) {
      return Row(children: [
        // 좋아요 아이콘
        Padding(
            padding: EdgeInsets.only(right: CustomSpacing.md),
            child: InkWell(
              onTap: _handleLike,
              child: Row(children: [
                CustomWidth.sm,
                Icon(
                    widget._feed.isLike
                        ? Icons.favorite
                        : Icons.favorite_border,
                    size: CustomTextSize.xl,
                    color: widget._feed.isLike
                        ? Theme.of(context).colorScheme.primaryContainer
                        : Theme.of(context).colorScheme.primary),
                CustomWidth.sm,
                Text('${widget._feed.likeCount}'),
                CustomWidth.sm
              ]),
            )),

        // 댓글 아이콘
        Padding(
            padding: EdgeInsets.only(right: CustomSpacing.md),
            child: InkWell(
              onTap: _handleComment,
              child: Row(children: [
                CustomWidth.sm,
                Icon(Icons.comment_outlined, size: CustomTextSize.xl),
                CustomWidth.sm,
                Text('${widget._feed.commentCount}'),
                CustomWidth.sm
              ]),
            )),

        // DM 아이콘
        Padding(
            padding: EdgeInsets.only(right: CustomSpacing.md),
            child: InkWell(
              onTap: _sendDM,
              child: Row(children: [
                CustomWidth.sm,
                Icon(Icons.send_and_archive_outlined, size: CustomTextSize.xl)
              ]),
            ))
      ]);
    });
  }
}
