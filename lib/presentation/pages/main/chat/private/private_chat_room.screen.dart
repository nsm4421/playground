part of 'private_chat.page.dart';

class PrivateChatRoomScreen extends StatefulWidget {
  const PrivateChatRoomScreen(this._opponent, {super.key});

  final AccountEntity _opponent;

  @override
  State<PrivateChatRoomScreen> createState() => _PrivateChatRoomScreenState();
}

class _PrivateChatRoomScreenState extends State<PrivateChatRoomScreen> {
  static const int _maxLength = 1000;
  late TextEditingController _tec;
  late AccountEntity _currentUser;
  List<PrivateChatMessageEntity> _messages = [];

  @override
  void initState() {
    super.initState();
    _tec = TextEditingController();
    _currentUser = (context.read<UserBloc>().state as UserLoadedState).account;
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

  _handleSubmit() {
    try {
      final content = _tec.text.trim();
      if (content.isEmpty) {
        return;
      }
      final message = PrivateChatMessageEntity(
          id: const Uuid().v4(),
          content: content,
          sender: _currentUser,
          receiver: widget._opponent,
          createdAt: DateTime.now(),
          type: ChatMessageType.text);
      context.read<SendPrivateChatMessageCubit>().send(message);
      setState(() {
        _tec.clear();
        _messages.add(message);
      });
    } catch (error) {
      log(error.toString());
      ToastUtil.toast('메세지 전송 실패');
    }
  }

  @override
  Widget build(BuildContext context) {
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
      body: Column(
        children: [
          /// 메세지 목록
          Expanded(
            child: BlocListener<DisplayPrivateChatMessageBloc,
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
                    final isMine = _currentUser.id == message.sender?.id;
                    return PrivateChatMessageItemWidget(
                        message: message, isMine: isMine);
                  }),
            ),
          ),

          /// 텍스트 입력
          BlocListener<SendPrivateChatMessageCubit,
              SendPrivateChatMessageState>(
            listener:
                (BuildContext context, SendPrivateChatMessageState state) {
              switch (state.status) {
                case Status.success:
                  _tec.clear();
                  return;
                case Status.error:
                  ToastUtil.toast(state.errorMessage ?? '메세지 전송 실패');
                  return;
                default:
              }
            },
            child: BlocBuilder<SendPrivateChatMessageCubit,
                SendPrivateChatMessageState>(builder: (context, state) {
              return TextField(
                  minLines: 1,
                  maxLines: 3,
                  maxLength: _maxLength,
                  controller: _tec,
                  decoration: (state.status == Status.initial) ||
                          (state.status == Status.success)
                      ? InputDecoration(
                          counterText: '',
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                              icon: const Icon(Icons.send),
                              onPressed: _handleSubmit))
                      : const InputDecoration(
                          counterText: '',
                          border: OutlineInputBorder(),
                          suffixIcon: Center(
                              heightFactor: 1,
                              widthFactor: 1,
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child:
                                    CircularProgressIndicator(strokeWidth: 3),
                              ))));
            }),
          )
        ],
      ),
    );
  }
}
