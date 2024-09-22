part of 'feed.page.dart';

class FeedItemWidget extends StatelessWidget {
  const FeedItemWidget(this._feed,
      {super.key, required CustomTimeFormat timeFormatter})
      : _timeFormatter = timeFormatter;

  final FeedEntity _feed;
  final CustomTimeFormat _timeFormatter;

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
              CircularAvatarImageWidget(_feed.author!.avatarUrl!, radius: 30),
              CustomWidth.sm,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_feed.author!.username!,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary)),
                  CustomHeight.sm,
                  // 작성시간 formatting
                  Text(_timeFormatter.timeAgo(_feed.createdAt!.toString()),
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: Theme.of(context).colorScheme.primary)),
                ],
              ),
              const Spacer(),
              // TODO : 더보기 이벤트 버튼 이벤트
              IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
            ],
          ),
        ),

        // 이미지
        Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(vertical: CustomSpacing.md),
            decoration: BoxDecoration(
                color: Colors.blueGrey[100],
                image: DecorationImage(
                    image: CachedNetworkImageProvider(_feed.media!),
                    fit: BoxFit.fitHeight),
                borderRadius: BorderRadius.circular(CustomSpacing.md))),

        // 캡션
        Padding(
            padding: EdgeInsets.symmetric(
                horizontal: CustomSpacing.sm, vertical: CustomSpacing.tiny),
            child: SizedBox(
                child: Text(_feed.caption!,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary),
                    overflow: TextOverflow.ellipsis,
                    softWrap: true))),

        // 해시태그
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: CustomSpacing.sm, vertical: CustomSpacing.tiny),
          child: Wrap(
            children: _feed.hashtags!
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
        IconMenuWidget(_feed),

        // 최신댓글
        if (_feed.latestComment != null)
          Padding(
              padding: EdgeInsets.symmetric(
                  vertical: CustomSpacing.md, horizontal: CustomSpacing.lg),
              child: Row(
                children: [
                  Text(
                    _feed.latestComment!.content!,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.tertiary),
                  ),
                  const Spacer(),
                  Text(
                    _timeFormatter
                        .timeAgo(_feed.latestComment!.createdAt!.toString()),
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
