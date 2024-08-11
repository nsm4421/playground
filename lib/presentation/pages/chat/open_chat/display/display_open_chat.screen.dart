part of "display_open_chat.page.dart";

class DisplayOpenChatScreen extends StatefulWidget {
  const DisplayOpenChatScreen({super.key});

  @override
  State<DisplayOpenChatScreen> createState() => _DisplayOpenChatScreenState();
}

class _DisplayOpenChatScreenState extends State<DisplayOpenChatScreen> {
  late Stream<List<OpenChatEntity>> _chatStream;

  @override
  void initState() {
    super.initState();
    _chatStream = context.read<DisplayOpenChatCubit>().chatStream;
  }

  _handleMoveToChat(OpenChatEntity chat) => () {
        context.push(RoutePaths.openChatRoom.path, extra: chat);
      };

  _handleMoveToCreateChatPage() {
    context.push(RoutePaths.createOpenChat.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Open Chat")),
      body: StreamBuilder<List<OpenChatEntity>>(
          stream: _chatStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            final data = snapshot.data ?? [];
            return ListView.separated(
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (context, index) {
                final item = data[index];
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ListTile(
                      onTap: _handleMoveToChat(item),
                      title: Text(item.title ?? "",
                          overflow: TextOverflow.ellipsis),
                      titleTextStyle: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.primary),
                      subtitle: item.lastMessage != null
                          ? Text(item.lastMessage!,
                              overflow: TextOverflow.ellipsis)
                          : null,
                      subtitleTextStyle:
                          Theme.of(context).textTheme.labelMedium,
                      trailing: item.lastTalkAt != null
                          ? Text(item.lastTalkAt!.format(),
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary),
                              overflow: TextOverflow.ellipsis)
                          : null,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 3),
                      child: HashtagsWidget(
                        item.hashtags,
                        bgColor: Colors.blueGrey,
                        textColor: Colors.white,
                      ),
                    )
                  ],
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(indent: 10, endIndent: 10);
              },
            );
          }),
      floatingActionButton: FloatingActionButton.small(
        onPressed: _handleMoveToCreateChatPage,
        child: const Icon(Icons.add),
      ),
    );
  }
}
