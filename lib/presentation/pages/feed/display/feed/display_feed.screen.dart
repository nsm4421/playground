part of "display_feed.page.dart";

class DisplayFeedScreen extends StatefulWidget {
  const DisplayFeedScreen({super.key});

  @override
  State<DisplayFeedScreen> createState() => _DisplayFeedScreenState();
}

class _DisplayFeedScreenState extends State<DisplayFeedScreen> {
  _handleMoveToCreatePage() {
    context.push(RoutePaths.createFeed.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FEED"),
        actions: [
          IconButton(
              tooltip: "Crate Feed",
              onPressed: _handleMoveToCreatePage,
              icon: const Icon(Icons.create))
        ],
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            // 피드 목록
            FeedListFragment(),
            // 더 가져오기 버튼
            FetchMoreButtonWidget()
          ],
        ),
      ),
    );
  }
}
