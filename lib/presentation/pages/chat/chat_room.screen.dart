import 'package:flutter/material.dart';

class ChatRoomScreen extends StatelessWidget {
  const ChatRoomScreen(this.chatRoomId, {super.key});

  final String chatRoomId;

  @override
  Widget build(BuildContext context) => chatRoomId.isEmpty
      ? const Center(child: Text("잘못된 접근입니다"))
      : Scaffold(
          appBar: AppBar(
            title: Text("ChatRoom ${chatRoomId}"),
          ),
        );
}
