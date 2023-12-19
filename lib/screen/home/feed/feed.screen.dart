import 'package:flutter/material.dart';
import 'package:my_app/screen/component/feed.fragment.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) => const FeedFragment(isMyFeed: false);
}
