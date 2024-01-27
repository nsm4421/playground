import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/core/constant/enums/status.enum.dart';
import 'package:my_app/dependency_injection.dart';
import 'package:my_app/presentation/pages/feed/bloc/feed.bloc.dart';
import 'package:my_app/presentation/pages/feed/bloc/feed.event.dart';
import 'package:my_app/presentation/pages/feed/bloc/feed.state.dart';
import 'package:my_app/presentation/pages/feed/feed_list.fragment.dart';

import '../../../core/constant/enums/routes.enum.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  _handleGoToWriteFeed() => context.push(Routes.feed.path);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Feed"),
          actions: [
            IconButton(
                onPressed: _handleGoToWriteFeed,
                icon: Icon(
                  Icons.add_box_outlined,
                  color: Theme.of(context).colorScheme.primary,
                ))
          ],
        ),
        body: Scaffold(
          body: BlocProvider(
            create: (_) => getIt<FeedBloc>()..add(FeedInitializedEvent()),
            child: BlocBuilder<FeedBloc, FeedState>(
              builder: (_, state) {
                switch (state.status) {
                  case Status.initial:
                  case Status.loading:
                    return const Center(child: CircularProgressIndicator());
                  case Status.success:
                    return const FeedListFragment();
                  case Status.error:
                    return const Center(child: Text("ERROR"));
                }
              },
            ),
          ),
        ),
      );
}
