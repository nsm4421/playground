part of 'feed.page.dart';

class FeedListFragment extends StatelessWidget {
  const FeedListFragment(this._feeds, {super.key});

  final List<FeedEntity> _feeds;

  @override
  Widget build(BuildContext context) {
    return _feeds.isEmpty
        ? const _OnEmpty()
        : ListView.builder(
            itemCount: _feeds.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return FeedItemWidget(_feeds[index]);
            });
  }
}

class _OnEmpty extends StatelessWidget {
  const _OnEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("NO FEED FOUNDED",
          style: Theme.of(context).textTheme.displayLarge),
    );
  }
}
