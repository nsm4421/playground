part of 'comment.page.dart';

class ParentCommentListFragment extends StatelessWidget {
  const ParentCommentListFragment({
    super.key,
    required this.comments,
    required this.timeFormatter,
  });

  final List<ParentFeedCommentEntity> comments;
  final CustomTimeFormat timeFormatter;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: comments.length,
        itemBuilder: (context, index) {
          final item = comments[index];
          return CommentListTile(
            timeFormatter: timeFormatter,
            avatarUrl: item.author!.avatarUrl!,
            content: item.content!,
            createdAt: item.createdAt!,
            trailing: GestureDetector(
              onTap: () {
                context
                    .read<FeedCommentBloc>()
                    .add(SelectParentCommentEvent(item));
              },
              child: item.childCommentCount > 0
                  ? Container(
                      padding: EdgeInsets.all(CustomSpacing.sm),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              Theme.of(context).colorScheme.secondaryContainer),
                      child: Text(item.childCommentCount.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSecondary)),
                    )
                  : const Icon(Icons.add_comment_outlined),
            ),
          );
        });
  }
}

class ChildCommentListFragment extends StatelessWidget {
  const ChildCommentListFragment(
      {super.key, required this.parentComment, required this.timeFormatter});

  final ParentFeedCommentEntity parentComment;
  final CustomTimeFormat timeFormatter;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 부모 댓글
        CommentListTile(
            timeFormatter: timeFormatter,
            avatarUrl: parentComment.author!.avatarUrl!,
            content: parentComment.content!,
            createdAt: parentComment.createdAt!),
        Padding(
          padding: EdgeInsets.symmetric(vertical: CustomSpacing.sm),
          child: Divider(indent: CustomSpacing.lg, endIndent: CustomSpacing.lg),
        ),
        // 자식댓글
        Padding(
          padding: EdgeInsets.only(left: CustomSpacing.xl),
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: parentComment.children.length,
              itemBuilder: (context, index) {
                final item = parentComment.children[index];
                return CommentListTile(
                    timeFormatter: timeFormatter,
                    avatarUrl: item.author!.avatarUrl!,
                    content: item.content!,
                    createdAt: item.createdAt!);
              }),
        ),
      ],
    );
  }
}
