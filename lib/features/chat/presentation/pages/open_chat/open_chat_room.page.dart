import 'package:flutter/material.dart';
import 'package:portfolio/features/chat/domain/entity/open_chat.entity.dart';

part "open_chat_room.screen.dart";

class OpenChatRoomPage extends StatelessWidget {
  const OpenChatRoomPage(this._chat, {super.key});

  final OpenChatEntity _chat;

  @override
  Widget build(BuildContext context) {
    return OpenChatRoomScreen(_chat);
  }
}
