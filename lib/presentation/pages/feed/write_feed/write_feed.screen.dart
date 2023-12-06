import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/presentation/pages/feed/write_feed/write_feed_error.screen.dart';
import 'package:my_app/presentation/pages/feed/write_feed/write_feed_success.screen.dart';
import 'package:my_app/presentation/pages/feed/write_feed/write_feed_view.screen.dart';


import '../../../../core/constant/enums/status.enum.dart';
import '../../../../dependency_injection.dart';
import '../bloc/write_feed.bloc.dart';
import '../bloc/write_feed.event.dart';
import '../bloc/write_feed.state.dart';

class WriteFeedScreen extends StatelessWidget {
  const WriteFeedScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: BlocProvider(
          create: (_) =>
              getIt<WriteFeedBloc>()..add(WriteFeedInitializedEvent()),
          child: BlocBuilder<WriteFeedBloc, WriteFeedState>(
            builder: (_, state) {
              switch (state.status) {
                case Status.loading:
                  return const Center(child: CircularProgressIndicator());
                case Status.initial:
                  return const WriteFeedViewScreen();
                case Status.success:
                  return const WriteFeedSuccessScreen();
                case Status.error:
                  return const WriteFeedErrorScreen();
              }
            },
          ),
        ),
      );
}
