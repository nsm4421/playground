part of "private_chat_room.page.dart";

class PrivateChatRoomScreen extends StatelessWidget {
  const PrivateChatRoomScreen(
      {super.key, required this.chatId, required this.opponent});

  final String chatId;
  final PresenceEntity opponent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            FetchMoreButtonWidget(chatId),
            Expanded(child: PrivateChatMessageListFragment(opponent)),
            PrivateChatRoomTextFieldWidget(opponent.id!)
          ],
        ));
  }
}
