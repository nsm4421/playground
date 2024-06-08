import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/core/constant/media.dart';
import 'package:my_app/core/dependency_injection/dependency_injection.dart';
import 'package:my_app/data/entity/feed/base/feed.entity.dart';
import 'package:my_app/presentation/bloc/feed/display/display_feed.bloc.dart';
import 'package:my_app/presentation/components/error.fragment.dart';
import 'package:my_app/presentation/components/loading.fragment.dart';
import 'package:my_app/presentation/components/stream_builder.widget.dart';
import 'package:my_app/presentation/components/video_preview/video_preview_item.widget.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../core/constant/routes.dart';
import '../../../bloc/feed/feed.bloc.dart';

part 'feed_item.widget.dart';

part 'feed_list.fragment.dart';

part 'feed.screen.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<FeedBloc>().display..add(InitDisplayFeedEvent()),
      child: BlocBuilder<DisplayFeedBloc, DisplayFeedState>(
        builder: (BuildContext context, DisplayFeedState state) {
          if ((state is InitialDisplayFeedState) ||
              (state is DisplayFeedSuccessState)) {
            return const FeedScreen();
          } else if (State is DisplayFeedLoadingState) {
            return const LoadingFragment();
          } else {
            return const ErrorFragment();
          }
        },
      ),
    );
  }
}
