import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/data/entity/chat/chat.entity.dart';

import '../../../../core/constant/routes.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  _handleGoToChatRoom(ChatEntity chat) {
    context.push(Routes.chatRoom.path, extra: chat);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CHAT"),
      ),
      body: ElevatedButton(
        onPressed: () {
          context.push(Routes.chatRoom.path, extra: ChatEntity());
        },
        child: Text("TEST"),
      ),
    );
  }
}
