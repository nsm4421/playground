import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hot_place/presentation/chat/widget/private_chat/private_chat_list.fragment.dart';

import '../../../../core/constant/route.constant.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _View();
  }
}

class _View extends StatefulWidget {
  const _View({super.key});

  @override
  State<_View> createState() => _ViewState();
}

class _ViewState extends State<_View> {
  _handleGoSearchUserPage() => context.push(Routes.searchUser.path);

  _handleGoToOpenChatPage() => context.push(Routes.openChat.path);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Messages"),
        actions: [
          IconButton(
              tooltip: "유저검색",
              onPressed: _handleGoSearchUserPage,
              icon: Icon(
                Icons.search,
                color: Theme.of(context).colorScheme.primary,
              )),
          IconButton(
              tooltip: "오픈채팅",
              onPressed: _handleGoToOpenChatPage,
              icon: Icon(
                Icons.people_outline,
                color: Theme.of(context).colorScheme.primary,
              ))
        ],
      ),
      body: const PrivateChatListFragment(),
    );
  }
}
