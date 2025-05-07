part of '../../export.pages.dart';

class DisplayFeedScreen extends StatefulWidget {
  const DisplayFeedScreen({super.key});

  @override
  State<DisplayFeedScreen> createState() => _DisplayFeedScreenState();
}

class _DisplayFeedScreenState extends State<DisplayFeedScreen> {
  late GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  void initState() {
    super.initState();
    _scaffoldKey =
        GlobalKey<ScaffoldState>(debugLabel: 'display-feed-scaffold-key');
  }

  Future<void> _handleRefresh() async {
    context.read<DisplayFeedBloc>().add(MountEvent());
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _handleRefresh,
      child: Scaffold(
        key: _scaffoldKey,
        endDrawerEnableOpenDragGesture: false,
        endDrawer: DisplayFeedDrawerFragment(_scaffoldKey),
        body: CustomScrollView(
          slivers: [
            const SliverAppBar(
              expandedHeight: 50,
              elevation: 0,
              floating: true,
              pinned: false,
              title: Text("Feeds"),
              actions: [EndDrawerButton()],
            ),
            BlocBuilder<DisplayFeedBloc, DisplayState<FeedEntity>>(
              builder: (context, state) => SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FeedItemWidget(state.data[index]),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 12,
                        ),
                        child: Divider(),
                      )
                    ],
                  ),
                  childCount: state.data.length,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
