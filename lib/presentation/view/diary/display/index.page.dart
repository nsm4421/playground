import 'dart:developer';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:travel/core/di/dependency_injection.dart';
import 'package:travel/domain/entity/diary/diary.dart';
import 'package:travel/presentation/bloc/bloc_module.dart';
import 'package:travel/presentation/bloc/diary/display/display_diary.bloc.dart';
import 'package:travel/presentation/widgets/widgets.dart';

part 'display_diaries.screen.dart';

part 'display_diary_appbar.widget.dart';

part 'item/diary_item.widget.dart';

part 'item/diary_deatil.screen.dart';

part 'item/hashtags.widget.dart';

class DisplayDiariesPage extends StatelessWidget {
  const DisplayDiariesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) =>
            getIt<BlocModule>().displayDiary..add(FetchDiariesEvent()),
        child: BlocBuilder<DisplayDiaryBloc, DisplayDiaryState>(
          builder: (context, state) {
            return LoadingOverLayScreen(
                isLoading: state.isFetching,
                loadingWidget: const Center(child: CircularProgressIndicator()),
                childWidget: DisplayDiariesScreen(state.diaries));
          },
        ));
  }
}
