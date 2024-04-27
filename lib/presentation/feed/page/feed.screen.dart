import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hot_place/core/di/dependency_injection.dart';
import 'package:hot_place/presentation/feed/bloc/base/feed.bloc.dart';
import 'package:hot_place/presentation/feed/page/feed_list.fragment.dart';

import '../../../core/constant/route.constant.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  _handleGoToUploadingFeedPage() {
    context.push(Routes.uploadFeed.path);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => getIt<FeedBloc>(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text("FEED"),
            actions: [
              IconButton(
                  onPressed: _handleGoToUploadingFeedPage,
                  icon: const Icon(Icons.add_box_outlined))
            ],
          ),
          body: const FeedListFragment(),
        ));
  }
}
