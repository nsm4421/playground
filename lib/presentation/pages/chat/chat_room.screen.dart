import 'package:flutter/material.dart';
import 'package:my_app/domain/model/chat/chat_message/chat_message.model.dart';
import 'package:my_app/domain/model/chat/chat_room/chat_room.model.dart';

import '../../../dependency_injection.dart';
import '../../../domain/repository/chat.repository.dart';

class ChatRoomScreen extends StatelessWidget {
  const ChatRoomScreen(this.chatRoom, {super.key});

  final ChatRoomModel chatRoom;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(chatRoom.chatRoomName ?? ''),
        ),
        body: StreamBuilder<List<ChatMessageModel>>(
          stream: getIt<ChatRepository>()
              .getChatMessageStream(chatRoom.chatRoomId!),
          initialData: [],
          builder: (_, snapshot) => SingleChildScrollView(
            child: Column(
              children: snapshot.data!.map((e) => Text(e.toString())).toList(),
            ),
          ),
        ),
      );
}
