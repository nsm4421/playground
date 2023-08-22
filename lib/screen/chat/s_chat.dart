import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  // TODO : 아이콘 클릭 이벤트
  _handleClickFloatingActionButton() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Text("CALL"),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _handleClickFloatingActionButton();
        },
        child: const Icon(Icons.chat),
      ),
    );
  }
}
