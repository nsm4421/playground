import 'package:flutter/material.dart';
import 'package:flutter_app/create_media/presentation/bloc/base/base.state.dart';
import 'package:flutter_app/create_media/presentation/bloc/create_feed/create_feed.cubit.dart';
import 'package:flutter_app/shared/shared.export.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:photo_manager/photo_manager.dart';
import '../../widgets/image_preview.widget.dart';

part 'select_image.screen.dart';

part 'detail.screen.dart';

part 'upload_success.screen.dart';

part 'select_directory.fragment.dart';

part 'display_current_album.widget.dart';

part 'un_authorized.screen.dart';

part 'add_hashtag.fragment.dart';

class CreateFeedPage extends StatelessWidget {
  const CreateFeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => getIt<CreateFeedCubit>()..askPermission(),
        child: BlocListener<CreateFeedCubit, CreateFeedState>(
          listener: (context, state) {
            if (state.step == CreateStep.uploading &&
                state.status == Status.success) {
              getIt<CustomSnakbar>().success(title: '포스팅 업로드 성공');
            } else if (state.status == Status.error) {
              Future.delayed(const Duration(seconds: 1), () {
                context.read<CreateFeedCubit>().reset();
                getIt<CustomSnakbar>().error(title: state.errorMessage);
              });
            } else if (state.status == Status.error &&
                state.step == CreateStep.uploading) {
              context.read<CreateFeedCubit>().reset(step: CreateStep.detail);
            }
          },
          child: BlocBuilder<CreateFeedCubit, CreateFeedState>(
              builder: (context, state) {
            if (!state.isAuth) {
              return const UnAuthorizedScreen();
            }
            return switch (state.step) {
              CreateStep.selectMedia => const SelectImageScreen(),
              CreateStep.detail => const DetailScreen(),
              CreateStep.uploading => (state.status == Status.success)
                  ? const UploadSuccessScreen()
                  : const Center(child: CircularProgressIndicator())
            };
          }),
        ));
  }
}
