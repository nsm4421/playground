part of "display_feed_comment.page.dart";

/// TODO : 댓글 좋아요 기능
class FeedCommentItemWidget extends StatelessWidget {
  const FeedCommentItemWidget(this._comment, {super.key});

  final FeedCommentEntity _comment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 프사
          if (_comment.createdBy?.profileImage != null)
            CircleAvatar(
                radius: 25,
                backgroundImage: CachedNetworkImageProvider(
                    _comment.createdBy!.profileImage!)),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 닉네임
              if (_comment.createdBy?.nickname != null)
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(_comment.createdBy!.nickname!,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: Theme.of(context).colorScheme.primary)),
                ),

              // 본문
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .secondaryContainer
                          .withOpacity(0.8),
                      borderRadius: BorderRadius.circular(10)),
                  width: MediaQuery.of(context).size.width - 96,
                  child: Text(
                    _comment.content ?? "",
                    softWrap: true,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        overflow: TextOverflow.visible,
                        color: Theme.of(context).colorScheme.onSecondary),
                  )),

              // 작성 시간
              Container(
                alignment: Alignment.centerRight,
                width: MediaQuery.of(context).size.width - 96,
                child: Text(_comment.createdAt!.format(),
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Theme.of(context).colorScheme.tertiary)),
              )
            ],
          )
        ],
      ),
    );
  }
}
