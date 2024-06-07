part of 'feed.page.dart';

class FeedItemWidget extends StatefulWidget {
  const FeedItemWidget(this._feed, {super.key});

  final FeedEntity _feed;

  @override
  State<FeedItemWidget> createState() => _FeedItemWidgetState();
}

class _FeedItemWidgetState extends State<FeedItemWidget> {
  // TODO : 버튼 이벤트 기능 구현하기
  _handleClickMore() {}

  _handleClickFavorite() {}

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          // TODO : 작성자 아바타, 닉네임 가져오기
          Row(
            children: [
              Text(widget._feed.createdBy ?? 'UNKNOWN'),
              IconButton(
                  onPressed: _handleClickMore,
                  icon: const Icon(Icons.more_vert))
            ],
          ),

          // Image
          if (widget._feed.type == MediaType.image &&
              widget._feed.media != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: CachedNetworkImage(imageUrl: widget._feed.media!),
            ),

          // Video
          if (widget._feed.type == MediaType.video &&
              widget._feed.media != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: VideoPreviewItemWidget(widget._feed.media!),
            ),
          //

          // Content
          if (widget._feed.content != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: Text(widget._feed.content ?? ''),
            ),

          // 해시태그
          if (widget._feed.hashtags.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: Wrap(
                children: widget._feed.hashtags
                    .map((text) => Chip(label: Text(text)))
                    .toList(),
              ),
            ),

          // 아이콘 버튼
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: IconButton(
                    onPressed: _handleClickFavorite,
                    icon: const Icon(Icons.favorite_border)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: IconButton(
                    onPressed: _handleClickFavorite,
                    icon: const Icon(Icons.mode_comment_outlined)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: IconButton(
                    onPressed: _handleClickFavorite,
                    icon: const Icon(Icons.share_rounded)),
              )
            ],
          )
        ],
      ),
    );
  }
}
