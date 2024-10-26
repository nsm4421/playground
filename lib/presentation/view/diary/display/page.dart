import 'dart:developer';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/bloc/display_bloc.dart';
import '../../../../core/constant/constant.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../domain/entity/diary/diary.dart';
import '../../../bloc/bloc_module.dart';
import '../../../bloc/diary/display/display_diary.bloc.dart';
import '../../../widgets/widgets.dart';

part 's_display_diaries.dart';

part 's_diary_detail.dart';

part 'w_display_diary_appbar.dart';

part 'w_diary_item.dart';

class DisplayDiariesPage extends StatelessWidget {
  const DisplayDiariesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => getIt<BlocModule>().displayDiary
          ..add(FetchEvent(refresh: true)),
        child: BlocBuilder<DisplayDiaryBloc, CustomDisplayState<DiaryEntity>>(
          builder: (context, state) {
            return LoadingOverLayScreen(
                isLoading: state.status == Status.loading,
                loadingWidget: const Center(child: CircularProgressIndicator()),
                childWidget: DisplayDiariesScreen(state.data));
          },
        ));
  }
}
