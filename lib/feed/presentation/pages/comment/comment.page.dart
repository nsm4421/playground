import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/feed/domain/entity/feed_comment.entity.dart';
import 'package:flutter_app/feed/presentation/bloc/comment/feed_comment.bloc.dart';
import 'package:flutter_app/feed/presentation/widgets/comment_list_tile.widget.dart';
import 'package:flutter_app/shared/shared.export.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

part 'comment.screen.dart';

part 'comment_list.fragment.dart';

class CommentPage extends StatelessWidget {
  const CommentPage(this._feedId, {super.key});

  final String _feedId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => getIt<FeedCommentBloc>(param1: _feedId)
          ..add(FetchParentFeedCommentEvent())
          ..add(InitFeedCommentEvent(isMounted: true)),
        child: BlocBuilder<FeedCommentBloc, FeedCommentState>(
          builder: (context, state) {
            return state.isMounted
                ? const ParentCommentScreen()
                : const Center(child: CircularProgressIndicator());
          },
        ));
  }
}
