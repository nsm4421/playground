part of 'index.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  // TODO : 스크롤 방향에 따라 앱바, naviagation바를 보여줄지 말지 결정하기

  _handleNavigateCreatePage() async {
    context.read<HomeBottomNavCubit>().switchVisible(false);
    await context.push(Routes.createFeed.path).whenComplete(
      () {
        context.read<HomeBottomNavCubit>().switchVisible(true);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feed'),
        actions: [
          IconButton(
            onPressed: _handleNavigateCreatePage,
            icon: Icon(
              Icons.edit,
              color: context.colorScheme.primary,
            ),
          )
        ],
      ),
      body: const FeedListFragment(),
    );
  }
}
