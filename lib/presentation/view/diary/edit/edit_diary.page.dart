import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:travel/core/di/dependency_injection.dart';
import 'package:travel/core/util/util.dart';
import 'package:travel/presentation/bloc/image_to_text/image_to_text.bloc.dart';
import 'package:travel/presentation/widgets/widgets.dart';
import 'package:uuid/uuid.dart';

import '../../../bloc/diary/edit/edit_diary.bloc.dart';

part 'edit_diary.screen.dart';

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
        create: (_) =>
            getIt<EditDiaryBloc>(param1: diaryId)..add(InitializeEvent()),
        child: BlocBuilder<EditDiaryBloc, EditDiaryState>(
          builder: (context, state) {
            return switch (state.step) {
              EditDiaryStep.initializing => const InitializeScreen(),
              EditDiaryStep.editing => const DiaryEditorScreen(),
              EditDiaryStep.metaData => const EditMetaDataScreen(),
              EditDiaryStep.uploading => const UploadingScreen(),
            };
          },
        ));
  }
}
