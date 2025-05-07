part of "display_feed.page.dart";

class DisplayFeedScreen extends StatefulWidget {
  const DisplayFeedScreen({super.key});

  @override
  State<DisplayFeedScreen> createState() => _DisplayFeedScreenState();
}

class _DisplayFeedScreenState extends State<DisplayFeedScreen> {

  // 피드 작성 페이지로 이동
  // 피드 작성이 성공한 경우 피드 목록 맨 앞에 추가
  _handleMoveToCreatePage() async {
    await context.push<FeedEntity?>(RoutePaths.createFeed.path).then((res) {
      if (res != null) {
        context.read<DisplayFeedBloc>().add(FeedCreatedEvent(res));
      }
    });
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
