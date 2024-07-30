part of "private_chat_room.page.dart";

class FetchMoreButtonWidget extends StatefulWidget {
  const FetchMoreButtonWidget(this.chatId, {super.key});

  final String chatId;

  @override
  State<FetchMoreButtonWidget> createState() => _FetchMoreButtonWidgetState();
}

class _FetchMoreButtonWidgetState extends State<FetchMoreButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrivateChatRoomBloc, PrivateChatRoomState>(
        builder: (context, state) {
      if (!state.isEnd) {
        return ElevatedButton(
            onPressed: () {
              context
                  .read<PrivateChatRoomBloc>()
                  .add(FetchPrivateChatMessageEvent());
            },
            child: const Text("Fetch More"));
      } else {
        return const SizedBox();
      }
    });
  }
}
