import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hot_place/presentation/chat/widget/private_chat/private_chat_list.fragment.dart';

import '../../../core/constant/route.constant.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  _handleGoToOpenChatPage() => context.push(Routes.openChat.path);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Messages"),
        actions: [
          IconButton(
              onPressed: _handleGoToOpenChatPage,
              icon: Icon(
                Icons.search,
                color: Theme.of(context).colorScheme.primary,
              ))
        ],
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 유저 목록
                Row(
                  children: List.generate(1000, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 5),
                      child: Column(
                        children: [
                          // TODO : 실제 유저 이미지
                          const CircleAvatar(child: Icon(Icons.abc)),
                          Text(
                            "nickname",
                            style: Theme.of(context).textTheme.labelSmall,
                          )
                        ],
                      ),
                    );
                  }),
                ),

                // 채팅방 목록
                const PrivateChatListFragment()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
