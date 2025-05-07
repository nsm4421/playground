import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:travel/core/constant/constant.dart';
import 'package:travel/core/di/dependency_injection.dart';
import 'package:travel/core/theme/theme.dart';
import 'package:travel/core/util/extension/extension.dart';
import 'package:travel/core/util/snackbar/snackbar.dart';
import 'package:travel/presentation/bloc/module.dart';
import 'package:travel/presentation/bloc/reels/create/bloc.dart';
import 'package:travel/presentation/widget/widget.dart';
import 'package:video_player/video_player.dart';

part 's_create.dart';

part 's_un_auth.dart';

part 'f_current_video.dart';

part 'f_caption.dart';

part 'f_display_asset.dart';

part 'w_asset_path.dart';

part 'w_fab.dart';

class CreateReelsPage extends StatelessWidget {
  const CreateReelsPage({super.key});

  static Duration _duration = 300.ms;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<BlocModule>().createReels..add(OnMountEvent()),
      child: BlocListener<CreateReelsBloc, CreateReelsState>(
        listener: (context, state) async {
          switch (state.status) {
            case Status.success:
              getIt<CustomSnackBar>().success(title: 'Success');
              await Future.delayed(_duration, () {
                context.pop();
              });
              break;
            case Status.error:
              getIt<CustomSnackBar>()
                  .error(title: 'Error', description: state.message);
              await Future.delayed(_duration, () {
                context
                    .read<CreateReelsBloc>()
                    .add(InitEvent(status: Status.initial, message: ''));
              });
              break;
            default:
              return;
          }
        },
        child: BlocBuilder<CreateReelsBloc, CreateReelsState>(
          builder: (context, state) {
            return state.isAuth
                ? LoadingOverLayWidget(
                    isLoading: (state.status == Status.loading) ||
                        (state.status == Status.success),
                    childWidget: const CreateReelsScreen(),
                  )
                : const UnAuthorizedScreen();
          },
        ),
      ),
    );
  }
}
