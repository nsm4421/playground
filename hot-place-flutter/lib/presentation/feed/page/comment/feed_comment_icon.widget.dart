import 'package:flutter/material.dart';
import 'package:hot_place/data/entity/feed/base/feed.entity.dart';

import 'feed_comment.screen.dart';

class FeedCommentIconWidget extends StatefulWidget {
  const FeedCommentIconWidget(this.feed, {super.key});

  final FeedEntity feed;

  @override
  State<FeedCommentIconWidget> createState() => _FeedCommentIconWidgetState();
}

class _FeedCommentIconWidgetState extends State<FeedCommentIconWidget> {
  _handleShowComment() => WidgetsBinding.instance.addPostFrameCallback((_) {
        showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (_) => FeedCommentScreen(widget.feed));
      });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _handleShowComment,
      icon: const Icon(Icons.comment_outlined),
    );
  }
}
