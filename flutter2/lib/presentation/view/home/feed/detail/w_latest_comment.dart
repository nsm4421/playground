part of 'index.dart';

class LatestCommentWidget extends StatelessWidget {
  const LatestCommentWidget(this.feed, {super.key});

  final FeedEntity feed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await showModalBottomSheet(
          context: context,
          showDragHandle: true,
          builder: (context) {
            return FeedCommentPage(feed);
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: context.colorScheme.tertiaryContainer.withOpacity(0.8),
        ),
        child: feed.latestComment == null
            ? Text(
                "No Comment",
                style: context.textTheme.labelLarge?.copyWith(
                  color: context.colorScheme.onTertiary,
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Comments',
                        style: context.textTheme.titleSmall
                            ?.copyWith(color: context.colorScheme.onTertiary),
                      ),
                      const Spacer(),
                      Transform.rotate(
                        angle: -0.45,
                        child: Icon(
                          Icons.arrow_forward_outlined,
                          color: context.colorScheme.onTertiary,
                        ),
                      )
                    ],
                  ),
                  (12.0).h,
                  Row(
                    children: [
                      Icon(
                        Icons.subdirectory_arrow_right,
                        color: context.colorScheme.onTertiary,
                      ),
                      (6.0).w,
                      Text(
                        feed.latestComment!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.colorScheme.onTertiary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
