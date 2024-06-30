part of 'open_chat.page.dart';

class OpenChatScreen extends StatefulWidget {
  const OpenChatScreen({super.key});

  @override
  State<OpenChatScreen> createState() => _OpenChatScreenState();
}

class _OpenChatScreenState extends State<OpenChatScreen> {
  late Stream<List<OpenChatEntity>> _stream;

  @override
  void initState() {
    super.initState();
    _stream = context.read<DisplayOpenChatBloc>().chatStream;
  }

  _handleGoToCreateOpenChat() {
    context.push(Routes.createOpenChat.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("오픈 채팅방")),

      // 채팅방 목록
      body: StreamBuilderWidget<List<OpenChatEntity>>(
          stream: _stream,
          onSuccessWidgetBuilder: (List<OpenChatEntity> data) {
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) =>
                    OpenChatItemWidget(data[index]));
          }),

      // 채팅방 만들기 페이지로
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
        label: Icon(Icons.create, color: Theme.of(context).colorScheme.primary),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        onPressed: _handleGoToCreateOpenChat,
        tooltip: "채팅방 만들기",
      ),
    );
  }
}
