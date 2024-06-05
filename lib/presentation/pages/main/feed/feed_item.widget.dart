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

          // Video
          if (widget._feed.videoUrl != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: VideoPreviewItemWidget(widget._feed.videoUrl!),
            ),

          // 이미지
          if (widget._feed.imageUrls.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: PageView.builder(itemBuilder: (context, index) {
                final imageUrl = widget._feed.imageUrls[index];
                return CachedNetworkImage(
                  imageUrl: imageUrl,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                          colorFilter: const ColorFilter.mode(
                              Colors.blueGrey, BlendMode.colorBurn)),
                    ),
                  ),
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                );
              }),
            ),

          // Text
          if (widget._feed.text != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: Text(widget._feed.text ?? ''),
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
              )
            ],
          )
        ],
      ),
    );
  }
}
