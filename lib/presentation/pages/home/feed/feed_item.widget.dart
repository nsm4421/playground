part of '../../export.pages.dart';

class FeedItemWidget extends StatelessWidget {
  const FeedItemWidget(this._feed, {super.key});

  final FeedEntity _feed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: context.colorScheme.primaryContainer.withOpacity(0.3),
          borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            child: Row(
              children: [
                CustomCircleAvatarWidget(_feed.author.profileImage),
                (12.width),
                Text(_feed.author.username),
                const Spacer(),
                IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
              ],
            ),
          ),
          if (_feed.images.isNotEmpty) CarouselWidget(_feed.images),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            child: Text(_feed.content),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.favorite_border),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.message_outlined),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.share),
              ),
            ],
          )
        ],
      ),
    );
  }
}
