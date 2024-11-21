import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:travel/core/theme/theme.dart';
import 'package:travel/core/util/extension/extension.dart';
import 'package:travel/domain/entity/feed/feed.dart';
import 'package:travel/presentation/view/home/feed/comment/index.dart';
import 'package:travel/presentation/widget/widget.dart';

part 's_detail.dart';

part 'w_feed_detail.dart';

part 'w_latest_comment.dart';

class FeedDetailPage extends StatelessWidget {
  const FeedDetailPage(this.feed, {super.key});

  final FeedEntity feed;

  @override
  Widget build(BuildContext context) {
    return FeedDetailScreen(feed);
  }
}
