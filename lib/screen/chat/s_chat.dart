import 'package:chat_app/common/routes/routes.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  _handleClickFloatingActionButton(BuildContext context) {
    Navigator.pushNamed(context, CustomRoutes.contract);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Text("CALL"),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _handleClickFloatingActionButton(context);
        },
        child: const Icon(Icons.chat),
      ),
    );
  }
}
