import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/constant/constant.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/util/util.dart';
import '../../../bloc/bloc_module.dart';
import '../../../bloc/feed/edit/edit_feed.bloc.dart';
import '../../../widgets/widgets.dart';

part 's_edit_feed.dart';

part 'f_editor_hashtag.dart';

part 'f_editor_content.dart';

part 'f_display_avatar.dart';

part 'w_edit_asset.dart';

part 'w_fab.dart';

class EditFeedPage extends StatelessWidget {
  const EditFeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final feedId = const Uuid().v4();
    return BlocProvider(
        create: (_) => getIt<BlocModule>().editFeed(feedId),
        child: BlocListener<EditFeedBloc, EditFeedState>(
          listener: (context, state) {
            if (state.status == Status.success) {
              Timer(const Duration(seconds: 1), () {
                context.read<EditFeedBloc>().add(ResetFeedEvent());
                // 업로드 성공 시, 메세지를 띄우고, 2초 뒤 화면 닫기
                customUtil.showSuccessSnackBar(
                    context: context, message: 'Success');
              });
            } else if (state.status == Status.error) {
              // 에러 발생시, 2초 뒤 원래 상태로 돌리고 snack bar띄우기
              customUtil.showErrorSnackBar(
                  context: context, message: state.errorMessage);
              Timer(const Duration(seconds: 1), () {
                context.read<EditFeedBloc>().add(
                    InitializeEvent(status: Status.initial, errorMessage: ''));
              });
            }
          },
          child: BlocBuilder<EditFeedBloc, EditFeedState>(
              builder: (context, state) {
            return LoadingOverLayScreen(
                isLoading: (state.status == Status.loading ||
                    state.status == Status.success),
                loadingWidget: const Center(child: CircularProgressIndicator()),
                childWidget: const EditFeedScreen());
          }),
        ));
  }
}
