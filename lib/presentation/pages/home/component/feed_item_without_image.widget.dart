import 'package:flutter/material.dart';
import 'package:my_app/domain/model/feed/feed.model.dart';
import 'package:my_app/presentation/pages/home/component/feed_item_content.widget.dart';
import 'package:my_app/presentation/pages/home/component/feed_item_header.widget.dart';
import 'package:my_app/presentation/pages/home/component/feed_item_icon_buttons.widget.dart';

class FeedItemWidgetWithoutImage extends StatefulWidget {
  const FeedItemWidgetWithoutImage(this.feed, {super.key});

  final FeedModel feed;

  @override
  State<FeedItemWidgetWithoutImage> createState() =>
      _FeedItemWidgetWithImageState();
}

class _FeedItemWidgetWithImageState extends State<FeedItemWidgetWithoutImage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          FeedItemHeader(widget.feed.uid!),
          FeedItemContentWidget(
              content: widget.feed.content ?? '',
              hashtags: widget.feed.hashtags),
          const FeedItemIconButtonsWidget()
        ],
      );
}
