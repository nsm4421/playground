import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:travel/core/constant/constant.dart';
import 'package:travel/core/di/dependency_injection.dart';
import 'package:travel/core/theme/theme.dart';
import 'package:travel/core/util/bloc/display_bloc.dart';
import 'package:travel/core/util/debounce/mixin.dart';
import 'package:travel/core/util/extension/extension.dart';
import 'package:travel/core/util/snackbar/snackbar.dart';
import 'package:travel/domain/entity/reels/reels.dart';
import 'package:travel/presentation/bloc/bottom_nav/cubit.dart';
import 'package:travel/presentation/bloc/module.dart';
import 'package:travel/presentation/bloc/reels/display/bloc.dart';
import 'package:travel/presentation/route/routes.dart';
import 'package:travel/presentation/widget/widget.dart';
import 'package:video_player/video_player.dart';

part 's_reels.dart';

part 'w_item.dart';

class ReelsPage extends StatelessWidget {
  const ReelsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<BlocModule>().displayReels..add(FetchEvent(take: 2)),
      child: BlocListener<DisplayReelsBloc, CustomDisplayState<ReelsEntity>>(
        listenWhen: (prev, curr) => (curr.status == Status.error),
        listener: (context, state) async {
          if (state.status == Status.error) {
            getIt<CustomSnackBar>()
                .error(title: 'Error', description: state.errorMessage);
            await Future.delayed(200.ms, () {
              context.read<DisplayReelsBloc>().add(
                  InitDisplayEvent<ReelsEntity>(
                      status: Status.initial, errorMessage: ''));
            });
          }
        },
        child: BlocBuilder<DisplayReelsBloc, CustomDisplayState<ReelsEntity>>(
          builder: (context, state) {
            return LoadingOverLayWidget(
              isLoading: state.status == Status.loading,
              loadingWidget: const Center(child: CircularProgressIndicator()),
              childWidget: ReelsScreen(),
            );
          },
        ),
      ),
    );
  }
}
