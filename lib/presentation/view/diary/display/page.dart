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
import '../../../bloc/bottom_nav/home_bottom_nav.cubit.dart';
import '../../../bloc/diary/display/display_diary.bloc.dart';
import '../../../bloc/like/like.cubit.dart';
import '../../../widgets/widgets.dart';
import 'comment/page.dart';

part 's_display_diaries.dart';

part 'detail/s_diary_detail.dart';

part 'w_diary_item.dart';

part 'w_icons.dart';

class DisplayDiariesPage extends StatelessWidget {
  const DisplayDiariesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) =>
            getIt<BlocModule>().displayDiary..add(FetchEvent(refresh: true)),
        child: const DisplayDiariesScreen());
  }
}
