import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel/core/constant/constant.dart';
import 'package:travel/core/di/dependency_injection.config.dart';
import 'package:travel/core/di/dependency_injection.dart';
import 'package:travel/core/theme/theme.dart';
import 'package:travel/core/util/bloc/display_bloc.dart';
import 'package:travel/core/util/extension/extension.dart';
import 'package:travel/core/util/snackbar/snackbar.dart';
import 'package:travel/domain/entity/comment/comment.dart';
import 'package:travel/domain/entity/feed/feed.dart';
import 'package:travel/presentation/bloc/comment/create/cubit.dart';
import 'package:travel/presentation/bloc/comment/display/bloc.dart';
import 'package:travel/presentation/bloc/module.dart';
import 'package:travel/presentation/widget/widget.dart';

part 'f_list.dart';

part 's_comment.dart';

part 'w_edit.dart';

part 'w_item.dart';

class FeedCommentPage extends StatelessWidget {
  const FeedCommentPage(this.feed, {super.key});

  final FeedEntity feed;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => getIt<BlocModule>().displayFeedComment(feed)
              ..add(FetchEvent<CommentEntity>())),
        BlocProvider(
            create: (_) => getIt<BlocModule>().createFeedComment(feed)),
      ],
      child: const FeedCommentScreen(),
    );
  }
}
