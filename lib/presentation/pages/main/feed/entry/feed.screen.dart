part of 'feed.page.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  _handleGoToUploadPage() {
    context.push(Routes.uploadFeed.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FEED"),
        actions: [
          IconButton(
              onPressed: _handleGoToUploadPage, icon: const Icon(Icons.add))
        ],
      ),
      body: const SingleChildScrollView(
        child: Column(children: [
          FeedListFragment(),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: FetchMoreFeedButtonWidget()),
        ]),
      ),
    );
  }
}
