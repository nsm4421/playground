import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/core/dependency_injection/dependency_injection.dart';
import 'package:my_app/presentation/bloc/feed/feed.bloc.dart';
import 'package:my_app/presentation/components/error.fragment.dart';
import 'package:my_app/presentation/components/loading.fragment.dart';

import '../../../../../core/constant/routes.dart';
import '../../../../components/video_preview/video_preview_for_upload.widget.dart';

part 'upload_feed.screen.dart';

class UploadFeedPage extends StatelessWidget {
  const UploadFeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<FeedBloc>()..add(InitFeedEvent()),
      child: BlocListener<FeedBloc, FeedState>(
        listener: (context, state) {
          if (state is UploadFeedSuccessState && context.mounted) {
            context.replace(Routes.entry.path);
          }
        },
        child: BlocBuilder<FeedBloc, FeedState>(
          builder: (context, state) {
            if (state is InitialFeedState || state is FeedSuccessState) {
              return const UploadFeedScreen();
            } else if (state is FeedLoadingState) {
              return const LoadingFragment();
            } else {
              return const ErrorFragment();
            }
          },
        ),
      ),
    );
  }
}
