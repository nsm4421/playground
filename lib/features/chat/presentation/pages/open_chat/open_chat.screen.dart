part of "open_chat.page.dart";

class OpenChatScreen extends StatefulWidget {
  const OpenChatScreen({super.key});

  @override
  State<OpenChatScreen> createState() => _OpenChatScreenState();
}

class _OpenChatScreenState extends State<OpenChatScreen> {
  _handleMoveToCreateChatRoomPage() {
    context.push(RoutePaths.createOpenChat.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Open Chat"),
        actions: [
          IconButton(
            onPressed: _handleMoveToCreateChatRoomPage,
            icon: const Icon(Icons.add),
            tooltip: "CREATE",
          )
        ],
      ),
    );
  }
}
