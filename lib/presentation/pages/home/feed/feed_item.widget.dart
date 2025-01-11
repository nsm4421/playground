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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CircleAvatar(),
                    (12.width),
                    Text(_feed.author.username),
                    const Spacer(),
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.more_vert))
                  ],
                ),
                (12.height),
                Text(_feed.content),
              ],
            ),
          ),
          if (_feed.images.isNotEmpty) CarouselWidget(_feed.images),
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
