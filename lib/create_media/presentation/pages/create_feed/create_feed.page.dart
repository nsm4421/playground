import 'package:flutter/material.dart';
import 'package:flutter_app/create_media/presentation/bloc/base/create_media.cubit.dart';
import 'package:flutter_app/create_media/presentation/bloc/create_feed/create_feed.bloc.dart';
import 'package:flutter_app/shared/shared.export.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:photo_manager/photo_manager.dart';
import '../../../constant/constant.dart';
import '../../widgets/image_preview.widget.dart';

part 'select_image.screen.dart';

part 'detail.screen.dart';

part 'select_directory.fragment.dart';

part 'display_current_album.widget.dart';

part 'un_authorized.screen.dart';

part 'add_hashtag.fragment.dart';

class CreateFeedPage extends StatelessWidget {
  const CreateFeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => getIt<CreateFeedBloc>()..add(FetchAlbumsEvent()),
        child: BlocListener<CreateFeedBloc, CreateFeedState>(
          listener: (context, state) {
            if (state.step == CreateMediaStep.uploading &&
                state.status == Status.success) {
              // 업데이트 완료한 경우 - 메세지 띄우고, 완료 페이지로 이동
              getIt<CustomSnakbar>().success(title: '포스팅 업로드 성공');
              Future.delayed(const Duration(seconds: 1), () {
                context
                    .read<CreateMediaCubit>()
                    .switchStep(CreateMediaStep.done);
              });
            } else if (state.status == Status.error) {
              // 오류가 발생한 경우 - 메세지 띄우고, status를 init으로 업데이트
              getIt<CustomSnakbar>()
                  .error(title: '에러가 발생했니다', description: state.errorMessage);
              Future.delayed(const Duration(seconds: 1), () {
                context
                    .read<CreateFeedBloc>()
                    .add(UpdateStateEvent(status: Status.initial));
              });
            }
          },
          child: BlocBuilder<CreateFeedBloc, CreateFeedState>(
              builder: (context, state) {
            if (!state.isAuth) {
              return const UnAuthorizedScreen();
            }
            return switch (state.step) {
              CreateMediaStep.selectMedia => const SelectImageScreen(),
              CreateMediaStep.detail => const DetailScreen(),
              _ => const Center(child: CircularProgressIndicator())
            };
          }),
        ));
  }
}
