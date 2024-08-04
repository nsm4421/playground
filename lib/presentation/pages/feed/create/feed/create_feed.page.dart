import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:portfolio/core/dependency_injection/configure_dependencies.dart';
import 'package:portfolio/presentation/bloc/feed/create/feed/create_feed.cubit.dart';
import 'package:portfolio/presentation/bloc/feed/feed.bloc_module.dart';
import 'package:portfolio/presentation/pages/main/components/error.screen.dart';
import 'package:portfolio/presentation/pages/main/components/hashtags.widget.dart';
import 'package:portfolio/presentation/pages/main/components/loading.screen.dart';

import '../../../../../core/constant/status.dart';
import '../../../../bloc/feed/create/feed/create_feed.state.dart';

part "create_feed.screen.dart";

class CreateFeedPage extends StatelessWidget {
  const CreateFeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => getIt<FeedBlocModule>().createFeed,
        child: BlocListener<CreateFeedCubit, CreateFeedState>(
            listener: (BuildContext context, state) {
          if (state.status == Status.success && context.mounted) {
            Timer(const Duration(seconds: 2), () {
              Fluttertoast.showToast(
                  msg: "create feed success", gravity: ToastGravity.TOP);
              context.pop();
            });
          } else if (state.status == Status.error) {
            Timer(const Duration(seconds: 2), () {
              Fluttertoast.showToast(
                  msg: "create feed fails", gravity: ToastGravity.TOP);
              context.read<CreateFeedCubit>().init();
            });
          }
        }, child: BlocBuilder<CreateFeedCubit, CreateFeedState>(
                builder: (context, state) {
          switch (state.status) {
            case Status.initial:
              return const CreateFeedScreen();
            case Status.success:
            case Status.loading:
            case Status.error:
              return const LoadingScreen();
          }
        })));
  }
}
