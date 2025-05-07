import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:travel/core/constant/constant.dart';
import 'package:travel/core/di/dependency_injection.dart';
import 'package:travel/core/theme/theme.dart';
import 'package:travel/core/util/extension/extension.dart';
import 'package:travel/core/util/snackbar/snackbar.dart';
import 'package:travel/presentation/bloc/feed/create/bloc.dart';
import 'package:travel/presentation/bloc/module.dart';
import 'package:travel/presentation/widget/widget.dart';

part 's_create.dart';

part 's_un_authorized.dart';

part './media/s_select_media.dart';

part 'detail/f_edit_caption.dart';

part './media/f_selected_images.dart';

part './media/f_display_asset.dart';

part './media/f_current_asset.dart';

part './media/w_asset_path.dart';

part 'detail/s_edit_caption.dart';

part 'detail/f_carousel.dart';

part './detail/f_hashtag.dart';

part 'w_button.dart';

class CreateFeedPage extends StatelessWidget {
  const CreateFeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<BlocModule>().createFeed..add(OnMountEvent()),
      child: BlocListener<CreateFeedBloc, CreateFeedState>(
        listener: (context, state) async {
          if (state.status == Status.error && !state.isAuth) {
            getIt<CustomSnackBar>().error(
                title: 'Authentication Error',
                description: 'permission denied');
          } else if (state.status == Status.error) {
            getIt<CustomSnackBar>()
                .error(title: 'Error', description: state.message);
            await Future.delayed(
              1.sec,
              () {
                context
                    .read<CreateFeedBloc>()
                    .add(InitEvent(status: Status.initial, message: ''));
              },
            );
          } else if (state.status == Status.success) {
            getIt<CustomSnackBar>().success(title: 'Success');
            context.pop();
          }
        },
        child: BlocBuilder<CreateFeedBloc, CreateFeedState>(
          builder: (context, state) {
            return LoadingOverLayWidget(
                isLoading: state.status == Status.loading ||
                    state.status == Status.success,
                loadingWidget: const Center(child: CircularProgressIndicator()),
                childWidget: state.isAuth
                    ? const CreateFeedScreen()
                    : const UnAuthorizedScreen());
          },
        ),
      ),
    );
  }
}
