part of 'feed.page.dart';

class IconMenuWidget extends StatefulWidget {
  const IconMenuWidget(this._feed, {super.key});

  final FeedEntity _feed;

  @override
  State<IconMenuWidget> createState() => _IconMenuWidgetState();
}

class _IconMenuWidgetState extends State<IconMenuWidget> {
  late bool _isLike;
  late int _likeCount;

  @override
  void initState() {
    super.initState();
    _isLike = widget._feed.isLike;
    _likeCount = widget._feed.likeCount;
  }

  bool get _isReady =>
      context.read<DisplayFeedBloc>().state.status != Status.loading &&
      context.read<DisplayFeedBloc>().state.status != Status.error;

  _handleLike() async {
    if (!_isReady) return;
    context.read<DisplayFeedBloc>().add(_isLike
        ? CancelLikeOnFeedEvent(widget._feed.id!)
        : LikeOnFeedEvent(widget._feed.id!));
    setState(() {
      _likeCount = _isLike ? _likeCount - 1 : _likeCount + 1;
      _isLike = !_isLike;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DisplayFeedBloc, DisplayFeedState>(
        builder: (context, state) {
      return Row(children: [
        // 좋아요 아이콘
        Padding(
            padding: EdgeInsets.only(right: CustomSpacing.md),
            child: Row(children: [
              IconButton(
                onPressed: _handleLike,
                icon: Icon(
                  widget._feed.isLike ? Icons.favorite : Icons.favorite_border,
                  size: CustomTextSize.xl,
                ),
                color: widget._feed.isLike
                    ? Theme.of(context).colorScheme.primaryContainer
                    : Theme.of(context).colorScheme.primary,
              ),
              Text('${widget._feed.likeCount}')
            ]))
      ]);
    });
  }
}
