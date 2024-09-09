import 'package:flutter/material.dart';
import 'package:flutter_app/feed/feed.export.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/shared.export.dart';

part 'feed.screen.dart';
part 'feed_item.widget.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FeedScreen();
  }
}
