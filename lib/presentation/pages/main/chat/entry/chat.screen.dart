part of 'chat.page.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<PrivateChatMessageEntity> _latestMessages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CHAT"),
        actions: [
          IconButton(
              onPressed: () {
                context.push(Routes.privateChatRoom.path,
                    extra: AccountEntity(
                        id: '5f866349-0684-499a-be41-38938b6b3175',
                        nickname: 'test2',
                        profileUrl:
                            'https://lwshjbjdarfenpzuuzdv.supabase.co/storage/v1/object/public/accounts/5f866349-0684-499a-be41-38938b6b3175/profile_image.jpg',
                        description: 'test2 user'));
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: BlocListener<DisplayPrivateChatMessageBloc,
              DisplayPrivateChatMessageState>(
          // 가장 최근 메세지 목록 가져오기
          listenWhen: (prev, curr) =>
              (prev is! LatestPrivateChatMessagesFetchedState) &&
              (curr is LatestPrivateChatMessagesFetchedState),
          listener: (context, state) {
            if (state is LatestPrivateChatMessagesFetchedState) {
              setState(() {
                _latestMessages.addAll(state.messages);
              });
            }
          },
          child: PrivateChatListFragment(_latestMessages)),
    );
  }
}
