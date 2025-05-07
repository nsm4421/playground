import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:travel/core/constant/constant.dart';
import 'package:travel/core/di/dependency_injection.dart';
import 'package:travel/core/theme/theme.dart';
import 'package:travel/core/util/bloc/display_bloc.dart';
import 'package:travel/core/util/extension/extension.dart';
import 'package:travel/core/util/snackbar/snackbar.dart';
import 'package:travel/domain/entity/feed/feed.dart';
import 'package:travel/presentation/bloc/bottom_nav/cubit.dart';
import 'package:travel/presentation/bloc/emotion/cubit.dart';
import 'package:travel/presentation/bloc/feed/display/bloc.dart';
import 'package:travel/presentation/bloc/module.dart';
import 'package:travel/presentation/route/routes.dart';
import 'package:travel/presentation/view/home/feed/comment/index.dart';
import 'package:travel/presentation/view/home/feed/detail/index.dart';
import 'package:travel/presentation/widget/widget.dart';

part 's_feed.dart';

part 'f_list.dart';

part 'w_item.dart';

part 'w_like.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<BlocModule>().displayFeed..add(FetchEvent()),
      child: BlocListener<DisplayFeedBloc, CustomDisplayState<FeedEntity>>(
        listener: (context, state) async {
          if (state.status == Status.error) {
            getIt<CustomSnackBar>()
                .error(title: 'Error', description: state.errorMessage);
            await Future.delayed(200.ms, () {
              context.read<DisplayFeedBloc>().add(InitDisplayEvent<FeedEntity>(
                  status: Status.initial, errorMessage: ''));
            });
          }
        },
        child: BlocBuilder<DisplayFeedBloc, CustomDisplayState<FeedEntity>>(
          builder: (context, state) {
            return LoadingOverLayWidget(
                isLoading: state.status == Status.loading,
                loadingWidget: const Center(child: CircularProgressIndicator()),
                childWidget: const FeedScreen());
          },
        ),
      ),
    );
  }
}
