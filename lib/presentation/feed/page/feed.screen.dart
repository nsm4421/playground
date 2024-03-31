import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text("FEED"),
        actions: [
          IconButton(
              onPressed: _handleGoToUploadingFeedPage,
              icon: const Icon(Icons.add_box_outlined))
        ],
      ),
    );
  }
}
