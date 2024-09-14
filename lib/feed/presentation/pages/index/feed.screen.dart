part of 'feed.page.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  initState() {
    super.initState();
    context.read<DisplayFeedBloc>().add(FetchFeedEvent());
  }

  Future<void> _refresh() async {
    context.read<DisplayFeedBloc>()
      ..add(RefreshEvent())
      ..add(FetchFeedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DisplayFeedBloc, DisplayFeedState>(
          builder: (context, state) {
        if (state.data.isEmpty && state.status == Status.loading) {
          // 피드 가져오는 중
          return const Center(child: CircularProgressIndicator());
        }
        return RefreshIndicator(
          onRefresh: _refresh,
          child: SingleChildScrollView(
            // physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                FeedListFragment(state.data),
                // 더 가져오기 버튼
                if (!state.isEnd)
                  Center(
                    child: state.status == Status.loading
                        ? const CircularProgressIndicator()
                        : IconButton(
                            onPressed: () {
                              context
                                  .read<DisplayFeedBloc>()
                                  .add(FetchFeedEvent());
                            },
                            icon: const Icon(Icons.rotate_left_outlined),
                          ),
                  )
              ],
            ),
          ),
        );
      }),
    );
  }
}
