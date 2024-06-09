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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // 프로필 사진
              AvatarWidget(widget._feed.author!.profileUrl!),
              const SizedBox(width: 8),

              // 닉네임
              Text(widget._feed.author?.nickname ?? 'Unknown'),
              const Spacer(),

              // 더보기 버튼
              IconButton(
                  onPressed: _handleClickMore,
                  icon: const Icon(Icons.more_vert))
            ],
          ),

          // Image
          if (widget._feed.type == MediaType.image &&
              widget._feed.media != null)
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: CachedNetworkImage(imageUrl: widget._feed.media!),
              ),
            ),

          // Video
          if (widget._feed.type == MediaType.video &&
              widget._feed.media != null)
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: VideoPreviewItemWidget(widget._feed.media!),
              ),
            ),

          // 본문
          if (widget._feed.content != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: Text(widget._feed.content ?? '',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: Theme.of(context).colorScheme.primary)),
            ),

          // 해시태그
          if (widget._feed.hashtags.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: Wrap(
                children: widget._feed.hashtags
                    .map((text) => Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .secondaryContainer,
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.tag, size: 20),
                            const SizedBox(width: 5),
                            Text(text,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSecondaryContainer)),
                          ],
                        )))
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
