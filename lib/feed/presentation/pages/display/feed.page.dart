import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/feed/presentation/pages/comment/comment.page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/shared.export.dart';
import '../../../domain/domain.export.dart';
import '../../bloc/comment/feed_comment.bloc.dart';
import '../../bloc/display/display_feed.bloc.dart';

part 'feed.screen.dart';

part 'feed_item.widget.dart';

part 'feed_list.fragment.dart';

part 'icon_menus.widget.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const FeedScreen();
  }
}
