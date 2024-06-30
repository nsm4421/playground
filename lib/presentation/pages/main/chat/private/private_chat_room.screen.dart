part of 'private_chat.page.dart';

class PrivateChatRoomScreen extends StatefulWidget {
  const PrivateChatRoomScreen(this._opponent, {super.key});

  final AccountEntity _opponent;

  @override
  State<PrivateChatRoomScreen> createState() => _PrivateChatRoomScreenState();
}

class _PrivateChatRoomScreenState extends State<PrivateChatRoomScreen> {
  late TextEditingController _tec;
  List<PrivateChatMessageEntity> _messages = [];

  @override
  void initState() {
    super.initState();
    _tec = TextEditingController();
    _messages = [];
  }

  @override
  void dispose() {
    super.dispose();
    _tec.dispose();
  }

  _handlePop() {
    if (context.mounted) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser =
        (context.read<UserBloc>().state as UserLoadedState).account;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._opponent.nickname!,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold)),
        leading: AvatarWidget(widget._opponent.profileUrl!),
        actions: [
          IconButton(onPressed: _handlePop, icon: const Icon(Icons.clear))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocListener<DisplayPrivateChatMessageBloc,
                DisplayPrivateChatMessageState>(
              listenWhen: (prev, curr) =>
                  (prev is! PrivateChatMessageFetchedState) &&
                  (curr is PrivateChatMessageFetchedState),
              listener: (context, state) {
                if (state is PrivateChatMessageFetchedState) {
                  _messages.addAll(state.messages);
                }
              },
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final message = _messages[index];
                    final isMine = currentUser.id == message.sender?.id;
                    return ListTile(
                      title: Text(message.content ?? ''),
                    );
                  }),
            ),

            // 키보드
            BlocBuilder<SendPrivateChatMessageCubit,
                SendPrivateChatMessageState>(
              builder: (context, state) =>
                  PrivateChatTextField(widget._opponent),
            )
          ],
        ),
      ),
    );
  }
}
