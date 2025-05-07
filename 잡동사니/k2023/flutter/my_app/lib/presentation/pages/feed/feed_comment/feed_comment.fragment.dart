import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/core/constant/enums/status.enum.dart';
import 'package:my_app/dependency_injection.dart';
import 'package:my_app/presentation/pages/feed/bloc/feed_comment.bloc.dart';
import 'package:my_app/presentation/pages/feed/bloc/feed_comment.event.dart';
import 'package:my_app/presentation/pages/feed/bloc/feed_comment.state.dart';
import 'package:my_app/presentation/pages/feed/feed_comment/feed_comment_view.widget.dart';

class FeedCommentFragment extends StatelessWidget {
  const FeedCommentFragment(this.feedId, {super.key});

  final String feedId;

  @override
  Widget build(BuildContext context) => BlocProvider(
      create: (_) =>
          getIt<FeedCommentBloc>()..add(FeedCommentInitializedEvent(feedId)),
      child: BlocBuilder<FeedCommentBloc, FeedCommentState>(
        builder: (_, state) {
          switch (state.status) {
            case Status.initial:
            case Status.loading:
              return const Center(child: CircularProgressIndicator());
            case Status.success:
              return  FeedCommentViewWidget(feedId);
            case Status.error:
              return const Text("ERROR");
          }
        },
      ));
}
