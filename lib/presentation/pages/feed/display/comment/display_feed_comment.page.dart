import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/core/util/date.util.dart';
import 'package:portfolio/core/dependency_injection/configure_dependencies.dart';
import 'package:portfolio/domain/entity/feed/feed.entity.dart';
import 'package:portfolio/domain/entity/feed/feed_comment.entity.dart';
import 'package:portfolio/presentation/bloc/feed/display/comment/display_feed_comment.bloc.dart';
import 'package:portfolio/presentation/bloc/feed/feed.bloc_module.dart';
import 'package:portfolio/presentation/pages/feed/create/comment/create_feed_comment.page.dart';

part "display_feed_comment.screen.dart";

part 'fetch_more_button.widget.dart';

part "feed_comment_list.fragment.dart";

part "feed_comment_item.widget.dart";

class DisplayFeedCommentPage extends StatelessWidget {
  const DisplayFeedCommentPage(this._feed, {super.key});

  final FeedEntity _feed;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => getIt<FeedBlocModule>().displayFeedComment(_feed.id!)
          ..add(FetchFeedCommentEvent()),
        child: const DisplayFeedCommentScreen());
  }
}
