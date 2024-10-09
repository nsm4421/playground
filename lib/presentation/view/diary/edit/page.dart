import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:travel/core/di/dependency_injection.dart';
import 'package:travel/core/util/util.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/constant/constant.dart';
import '../../../bloc/bloc_module.dart';
import '../../../bloc/diary/edit/edit_diary.bloc.dart';
import '../../../widgets/widgets.dart';

part 's_edit_diary.dart';

part 'f_editor_hashtag.dart';

part 'f_editor_content.dart';

part 'f_display_avatar.dart';

part 'w_fab_item.dart';

part 'w_edit_asset.dart';

class EditDiaryPage extends StatelessWidget {
  const EditDiaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final diaryId = const Uuid().v4();
    return BlocProvider(
        create: (_) => getIt<BlocModule>().editDiary(diaryId),
        child: BlocListener<EditDiaryBloc, EditDiaryState>(
          listener: (context, state) {
            if (state.status == Status.success) {
              Timer(const Duration(seconds: 1), () {
                context.read<EditDiaryBloc>().add(ResetDiaryEvent());
                // 업로드 성공 시, 메세지를 띄우고, 2초 뒤 화면 닫기
                customUtil.showSuccessSnackBar(
                    context: context, message: 'Success');
              });
            } else if (state.status == Status.error) {
              // 에러 발생시, 2초 뒤 원래 상태로 돌리고 snack bar띄우기
              customUtil.showErrorSnackBar(
                  context: context, message: state.errorMessage);
              Timer(const Duration(seconds: 1), () {
                context.read<EditDiaryBloc>().add(
                    InitializeEvent(status: Status.initial, errorMessage: ''));
              });
            }
          },
          child: BlocBuilder<EditDiaryBloc, EditDiaryState>(
              builder: (context, state) {
            return LoadingOverLayScreen(
                isLoading: (state.status == Status.loading ||
                    state.status == Status.success),
                loadingWidget: const Center(child: CircularProgressIndicator()),
                childWidget: const EditDiaryScreen());
          }),
        ));
  }
}
