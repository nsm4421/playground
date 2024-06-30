part of 'feed.page.dart';

class FeedListFragment extends StatefulWidget {
  const FeedListFragment({super.key});

  @override
  State<FeedListFragment> createState() => _FeedListFragmentState();
}

class _FeedListFragmentState extends State<FeedListFragment> {
  List<FeedEntity> _feeds = [];

  @override
  Widget build(BuildContext context) {
    return BlocListener<DisplayFeedBloc, DisplayFeedState>(
        listenWhen: (prev, curr) {
          return curr is FeedFetchedState;
        },
        listener: (context, state) {
          if (state is FeedFetchedState) {
            setState(() {
              _feeds.addAll(state.fetched);
            });
          }
        },
        child: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _feeds.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return FeedItemWidget(_feeds[index]);
          },
          separatorBuilder: (BuildContext context, int index) => const Padding(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: Divider(),
          ),
        ));
  }
}
