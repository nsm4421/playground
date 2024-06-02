import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/core/dependency_injection/dependency_injection.dart';
import 'package:my_app/data/entity/short/short.entity.dart';
import 'package:my_app/presentation/bloc/short/short.bloc.dart';
import 'package:my_app/presentation/components/error.fragment.dart';
import 'package:my_app/presentation/components/loading.fragment.dart';
import 'package:my_app/presentation/components/stream_builder.widget.dart';
import 'package:my_app/presentation/components/video_preview/video_preview_item.widget.dart';

import '../../../../core/constant/routes.dart';

part 'short_item.widget.dart';

part 'short_list.widget.dart';

part 'short_view.fragment.dart';

class ShortScreen extends StatefulWidget {
  const ShortScreen({super.key});

  @override
  State<ShortScreen> createState() => _ShortScreenState();
}

class _ShortScreenState extends State<ShortScreen> {

  // late Stream<List<ShortEntity>> _stream;
  List<ShortEntity> _shorts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SHORT"),
        actions: [
          IconButton(
              onPressed: () {
                context.push("/${Routes.uploadShort.path}");
              },
              icon: const Icon(Icons.upload))
        ],
      ),
      body: BlocProvider(
        create: (context) => getIt<ShortBloc>(),
        child: BlocBuilder<ShortBloc, ShortState>(
          builder: (BuildContext context, ShortState state) {
            if ((state is InitialShortState) || (state is ShortSuccessState)) {
              return const ShortViewFragment();
            } else if (State is ShortLoadingState) {
              return const LoadingFragment();
            } else {
              return const ErrorFragment();
            }
          },
        ),
      ),
    );
  }
}
