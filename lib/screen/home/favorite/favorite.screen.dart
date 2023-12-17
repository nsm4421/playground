import 'package:flutter/material.dart';
import 'package:my_app/screen/home/favorite/follow.fragment.dart';
import 'package:my_app/screen/home/favorite/reply.fragment.dart';

import 'all.fragment.dart';

enum _FavoriteTabItems {
  feed(label: 'Feed', fragment: AllFragment()),
  reply(label: 'Follows', fragment: FollowFragment()),
  repost(label: 'Reposts', fragment: ReplyFragment());

  final String label;
  final Widget fragment;

  const _FavoriteTabItems({required this.label, required this.fragment});
}

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      length: _FavoriteTabItems.values.length,
      vsync: this,
      initialIndex: 0,
      animationDuration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text("Activity"), centerTitle: true),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              TabBar(
                controller: _controller,
                indicatorColor: Theme.of(context).colorScheme.secondary,
                labelColor: Theme.of(context).colorScheme.primary,
                labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                unselectedLabelColor: Theme.of(context).colorScheme.tertiary,
                tabs: _FavoriteTabItems.values
                    .map((e) => SizedBox(
                        width: double.infinity, child: Tab(text: e.label)))
                    .toList(),
              ),
              Expanded(
                child: TabBarView(
                    controller: _controller,
                    children: _FavoriteTabItems.values
                        .map((e) => e.fragment)
                        .toList()),
              )
            ],
          ),
        ),
      );
}
