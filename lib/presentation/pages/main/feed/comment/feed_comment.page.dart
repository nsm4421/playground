import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/core/dependency_injection/dependency_injection.dart';
import 'package:my_app/data/entity/feed/base/feed.entity.dart';
import 'package:my_app/data/entity/feed/comment/feed_comment.entity.dart';
import 'package:my_app/presentation/bloc/feed/comment/display/display_feed_comment.bloc.dart';
import 'package:my_app/presentation/bloc/feed/comment/feed_comment.bloc.dart';
import 'package:my_app/presentation/bloc/feed/comment/upload/upload_feed_comment.cubit.dart';
import 'package:my_app/presentation/components/error.fragment.dart';
import 'package:my_app/presentation/components/loading.fragment.dart';
import 'package:my_app/presentation/components/user/avatar.widget.dart';

part 'feed_comment.screen.dart';

part 'comment_list.fragment.dart';

class FeedCommentPage extends StatelessWidget {
  const FeedCommentPage(this._feed, {super.key});

  final FeedEntity _feed;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (_) => getIt<FeedCommentBloc>(param1: _feed).upload),
      BlocProvider(
          create: (_) => getIt<FeedCommentBloc>(param1: _feed).display
            ..add(FetchDisplayFeedCommentEvent()))
    ], child: FeedCommentScreen(_feed));
  }
}
