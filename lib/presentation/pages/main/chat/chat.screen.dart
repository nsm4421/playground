import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constant/routes.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CHAT"),
        actions: [
          IconButton(
              onPressed: () {
                context.push(Routes.openChat.path);
              },
              icon: const Icon(Icons.add))
        ],
      ),
    );
  }
}
