part of 'index.dart';

class FeedDetailScreen extends StatelessWidget {
  const FeedDetailScreen(this.feed, {super.key});

  final FeedEntity feed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FeedDetailWidget(feed),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: LatestCommentWidget(feed),
            )
          ],
        ),
      ),
    );
  }
}
