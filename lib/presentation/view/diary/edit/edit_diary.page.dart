import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:travel/core/di/dependency_injection.dart';
import 'package:travel/core/util/util.dart';
import 'package:travel/presentation/widgets/widgets.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/constant/constant.dart';
import '../../../bloc/diary/edit/edit_diary.bloc.dart';

part 'initializing/initialize.screen.dart';

part 'edit/diary_editor.screen.dart';

part 'meta/edit_meta_data.screen.dart';

part 'uploading/uploading.screen.dart';

part 'edit/editor_page_item.widget.dart';

part 'edit/editor_header.fragment.dart';

part 'edit/editor_appbar.widget.dart';

part 'edit/editor_body.fragment.dart';

part 'edit/fab.widget.dart';

part 'meta/hashtag.fragment.dart';

part 'meta/location.fragment.dart';

class EditDiaryPage extends StatelessWidget {
  const EditDiaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final diaryId = const Uuid().v4();
    return BlocProvider(
        create: (_) => getIt<EditDiaryBloc>(param1: diaryId),
        child: BlocListener<EditDiaryBloc, EditDiaryState>(
          listener: (context, state) {
            if (state.step == EditDiaryStep.uploading &&
                state.status == Status.success) {
              // 업로드 성공 시, 메세지를 띄우고, 2초 뒤 화면 닫기
              customUtil.showSuccessSnackBar(
                  context: context, message: 'Success');
              Timer(const Duration(seconds: 2), () {
                context.pop();
              });
            } else if (state.status == Status.error) {
              // 에러 발생시, 2초 뒤 원래 상태로 돌리고 snack bar띄우기
              customUtil.showErrorSnackBar(
                  context: context, message: state.errorMessage);
              Timer(const Duration(seconds: 2), () {
                context.read<EditDiaryBloc>().add(InitializeEvent(
                    step: state.step == EditDiaryStep.uploading
                        ? EditDiaryStep.metaData
                        : state.step,
                    status: Status.initial,
                    errorMessage: ''));
              });
            }
          },
          child: BlocBuilder<EditDiaryBloc, EditDiaryState>(
            builder: (context, state) {
              return switch (state.step) {
                EditDiaryStep.initializing => const InitializeScreen(),
                EditDiaryStep.editing => const DiaryEditorScreen(),
                EditDiaryStep.metaData => const EditMetaDataScreen(),
                EditDiaryStep.uploading => const UploadingScreen(),
              };
            },
          ),
        ));
  }
}
