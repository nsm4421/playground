import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/core/dependency_injection/configure_dependencies.dart';
import 'package:portfolio/domain/entity/feed/feed.entity.dart';
import 'package:portfolio/presentation/bloc/feed/create/comment/create_comment.cubit.dart';
import 'package:portfolio/presentation/bloc/feed/feed.bloc_module.dart';
import 'package:portfolio/presentation/pages/main/components/error.screen.dart';
import 'package:portfolio/presentation/pages/main/components/loading.screen.dart';

import '../../../../../core/constant/status.dart';
import '../../../../bloc/feed/create/comment/create_comment.state.dart';

part "create_feed_comment.screen.dart";

class CreateFeedCommentPage extends StatelessWidget {
  const CreateFeedCommentPage(this._feedId, {super.key});

  final String _feedId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<FeedBlocModule>().createComment(_feedId),
      child: BlocListener<CreateCommentCubit, CreateCommentState>(
        listenWhen: (prev, curr) => prev.status != curr.status,
        listener: (context, state) {
          if (state.status == Status.success && context.mounted) {
            Timer(const Duration(seconds: 1), () {
              Fluttertoast.showToast(msg: 'success');
              context.pop();
            });
          } else if (state.status == Status.error) {
            Timer(const Duration(seconds: 1), () {
              Fluttertoast.showToast(msg: 'fail');
              context.read<CreateCommentCubit>().init();
            });
          }
        },
        child: BlocBuilder<CreateCommentCubit, CreateCommentState>(
          builder: (context, state) {
            switch (state.status) {
              case Status.initial:
                return const CreateFeedCommentScreen();
              case Status.loading:
              case Status.success:
                return const Center(child: CircularProgressIndicator());
              case Status.error:
                return const ErrorScreen();
            }
          },
        ),
      ),
    );
  }
}
