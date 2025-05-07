import 'package:flutter/material.dart';
import 'package:my_app/core/constant/user.enum.dart';
import 'package:my_app/screen/home/chat/chat_list.fragment.dart';

import '../../component/follow_list.widget.dart';

enum _ChatTabItems {
  chat(label: 'Chat', fragment: ChatListFragment()),
  reply(label: 'Followers', fragment: FollowListWidget(FollowType.follower)),
  repost(label: 'Followings', fragment: FollowListWidget(FollowType.following));

  final String label;
  final Widget fragment;

  const _ChatTabItems({required this.label, required this.fragment});
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      length: _ChatTabItems.values.length,
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
                tabs: _ChatTabItems.values
                    .map((e) => SizedBox(
                        width: double.infinity, child: Tab(text: e.label)))
                    .toList(),
              ),
              Expanded(
                child: TabBarView(
                    controller: _controller,
                    children:
                        _ChatTabItems.values.map((e) => e.fragment).toList()),
              )
            ],
          ),
        ),
      );
}
