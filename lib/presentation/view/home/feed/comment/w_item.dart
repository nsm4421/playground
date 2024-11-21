part of 'index.dart';

class FeedCommentItemWidget extends StatelessWidget {
  const FeedCommentItemWidget(this.comment, {super.key});

  final CommentEntity comment;

  @override
  Widget build(BuildContext context) {
    final dt = comment.createdAt!.toLocal();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        // TODO : 버튼 누르면 자식 댓글 화면으로
      },
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CachedCircularImageWidget(comment.author.avatarUrl),
                  (12.0).w,
                  Text(comment.author.username,
                      style: context.textTheme.bodySmall),
                  const Spacer(),
                  // TODO : Time formatting
                  Text(
                    '${dt.year}-${dt.month}-${dt.day}',
                    style: context.textTheme.labelSmall,
                  )
                ],
              ),
              (16.0).h,
              Row(
                children: [
                  (12.0).w,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ExpandableTextWidget(comment.content,
                            textStyle: context.textTheme.bodyMedium),
                        if (comment.childCount > 0)
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Text(
                              '${comment.childCount.toString()} Replies',
                              style: context.textTheme.titleSmall?.copyWith(
                                color: CustomPalette.secondary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                  (12.0).w,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
