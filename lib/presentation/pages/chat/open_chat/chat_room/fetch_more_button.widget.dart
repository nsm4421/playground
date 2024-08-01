part of "open_chat_room.page.dart";

class FetchMoreButtonWidget extends StatefulWidget {
  const FetchMoreButtonWidget(this.chatId, {super.key});

  final String chatId;

  @override
  State<FetchMoreButtonWidget> createState() => _FetchMoreButtonWidgetState();
}

class _FetchMoreButtonWidgetState extends State<FetchMoreButtonWidget> {
  int _page = 1;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OpenChatRoomBloc, OpenChatRoomState>(
        builder: (context, state) {
      if (!state.isEnd) {
        return ElevatedButton(
            onPressed: () {
              context
                  .read<OpenChatRoomBloc>()
                  .add(FetchOpenChatMessageEvent(_page));
              _page++;
            },
            child: const Text("Fetch More"));
      } else {
        return const SizedBox();
      }
    });
  }
}
