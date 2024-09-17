import 'package:flutter/material.dart';
import 'package:flutter_app/shared/shared.export.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:uuid/uuid.dart';
import '../../bloc/create/create_feed.bloc.dart';
import '../../widgets/image_preview.widget.dart';
import '../../widgets/select_directory.fragment.dart';

part 'select_image.screen.dart';

part 'detail.screen.dart';

part 'display_current_album.widget.dart';

part 'add_hashtag.fragment.dart';

part 'un_authorized.screen.dart';

class CreateFeedPage extends StatelessWidget {
  const CreateFeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => getIt<CreateFeedBloc>()..add(AskPermissionEvent()),
        child: BlocListener<CreateFeedBloc, CreateFeedState>(
          listener: (context, state) {
            if (state.step == CreateMediaStep.done) {
              // 업데이트 완료한 경우 - 메세지 띄우고, 초기화면으로 이동
              getIt<CustomSnakbar>().success(title: '포스팅 업로드 성공');
              Future.delayed(const Duration(seconds: 1), () {
                context.read<CreateFeedBloc>().add(UpdateStateEvent(
                      id: const Uuid().v4(),
                      status: Status.initial,
                      step: CreateMediaStep.selectMedia,
                    ));
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
            return switch (state.step) {
              CreateMediaStep.permission => const UnAuthorizedScreen(),
              CreateMediaStep.selectMedia => const SelectImageScreen(),
              CreateMediaStep.detail => const DetailScreen(),
              _ => const Center(child: CircularProgressIndicator())
            };
          }),
        ));
  }
}
