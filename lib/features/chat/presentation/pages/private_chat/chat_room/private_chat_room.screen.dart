part of "private_chat_room.page.dart";

class PrivateChatRoomScreen extends StatelessWidget {
  const PrivateChatRoomScreen(
      {super.key, required this.chatId, required this.receiver});

  final String chatId;
  final PresenceEntity receiver;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
