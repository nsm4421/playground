import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel/core/di/dependency_injection.dart';
import 'package:travel/core/util/bloc/display_bloc.dart';
import 'package:travel/domain/entity/comment/comment.dart';
import 'package:travel/domain/entity/feed/feed.dart';
import 'package:travel/presentation/bloc/module.dart';
import 'package:travel/presentation/widget/widget.dart';

class FeedCommentPage extends StatelessWidget {
  const FeedCommentPage(this.feed, {super.key, this.showAppBar = false});

  final FeedEntity feed;
  final bool showAppBar;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<BlocModule>().displayFeedComment(feed)
            ..add(
              FetchEvent<CommentEntity>(),
            ),
        ),
        BlocProvider(
          create: (_) => getIt<BlocModule>().createFeedComment(feed),
        ),
      ],
      child: SafeArea(
        child: Scaffold(
          appBar: showAppBar ? AppBar() : null,
          body: const CommentListWidget<FeedEntity>(),
          bottomNavigationBar: const EditCommentWidget<FeedEntity>(),
        ),
      ),
    );
  }
}
