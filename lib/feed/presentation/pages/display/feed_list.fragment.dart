part of 'feed.page.dart';

class FeedListFragment extends StatelessWidget {
  const FeedListFragment(this._feeds, {super.key});

  final List<FeedEntity> _feeds;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _feeds.length,
        itemBuilder: (context, index) {
          return FeedItemWidget(_feeds[index]);
        });
  }
}
