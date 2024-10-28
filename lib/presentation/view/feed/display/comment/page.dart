import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/bloc/display_bloc.dart';
import '../../../../../core/constant/constant.dart';
import '../../../../../core/di/dependency_injection.dart';
import '../../../../../core/util/util.dart';
import '../../../../../domain/entity/comment/comment.dart';
import '../../../../../domain/entity/feed/feed.dart';
import '../../../../bloc/bloc_module.dart';
import '../../../../bloc/comment/display/display_comment.bloc.dart';
import '../../../../bloc/comment/edit/edit_comment.bloc.dart';
import '../../../../widgets/widgets.dart';

part 's_comment.dart';

part 'f_comment_list.dart';

part 'f_edit_comment.dart';

class FeedCommentPage extends StatelessWidget {
  const FeedCommentPage(this._feed, {super.key});

  final FeedEntity _feed;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
          create: (_) => getIt<BlocModule>().displayFeedComment(_feed)
            ..add(FetchEvent())),
      BlocProvider(create: (_) => getIt<BlocModule>().editFeedComment(_feed))
    ], child: const FeedCommentScreen());
  }
}
