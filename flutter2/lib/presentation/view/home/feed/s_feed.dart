part of 'index.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  bool _exposeAppBar = true;

  late ScrollController _controller;

  @override
  initState() {
    super.initState();
    _controller = ScrollController()..addListener(_handleControllerListener);
  }

  @override
  dispose() {
    super.dispose();
    _controller
      ..removeListener(_handleControllerListener)
      ..dispose();
  }

  _handleControllerListener() {
    setState(() {
      _exposeAppBar =
          _controller.position.userScrollDirection != ScrollDirection.reverse;
    });
  }

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
      appBar: _exposeAppBar
          ? AppBar(
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
            )
          : null,
      body: FeedListFragment(_controller),
    );
  }
}
