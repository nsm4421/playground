import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:travel/core/bloc/display_bloc.dart';
import 'package:travel/core/di/dependency_injection.dart';

import '../../../../../core/constant/constant.dart';
import '../../../../../core/util/util.dart';
import '../../../../../domain/entity/comment/comment.dart';
import '../../../../../domain/entity/diary/diary.dart';
import '../../../../bloc/bloc_module.dart';
import '../../../../bloc/comment/display/display_comment.bloc.dart';
import '../../../../bloc/comment/edit/edit_comment.bloc.dart';
import '../../../../widgets/widgets.dart';

part 's_comment.dart';

part 'f_comment_list.dart';

part 'f_edit_comment.dart';

class DiaryCommentPage extends StatelessWidget {
  const DiaryCommentPage(this._diary, {super.key});

  final DiaryEntity _diary;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
          create: (_) => getIt<BlocModule>().displayDiaryComment(_diary)
            ..add(FetchEvent())),
      BlocProvider(create: (_) => getIt<BlocModule>().editDiaryComment(_diary))
    ], child: const DiaryCommentScreen());
  }
}
