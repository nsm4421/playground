import 'package:flutter/material.dart';
import 'package:my_app/domain/model/feed/feed.model.dart';
import 'package:my_app/presentation/pages/home/component/feed_item_with_image.widget.dart';
import 'package:my_app/presentation/pages/home/component/feed_item_without_image.widget.dart';

class FeedItemWidget extends StatelessWidget {
  const FeedItemWidget(this.feed, {super.key});

  final FeedModel feed;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          const SizedBox(height: 8),
          feed.images.isEmpty
              ? FeedItemWidgetWithoutImage(feed)
              : FeedItemWidgetWithImageWidget(feed),
          const SizedBox(height: 8),
          Divider(thickness: 1, color: Colors.blueGrey.withOpacity(0.5))
        ],
      );
}
