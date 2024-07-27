part of "open_chat_room.page.dart";

class OpenChatRoomTextFieldWidget extends StatefulWidget {
  const OpenChatRoomTextFieldWidget(this._chatId, {super.key});

  final String _chatId;

  @override
  State<OpenChatRoomTextFieldWidget> createState() =>
      _OpenChatRoomTextFieldWidgetState();
}

class _OpenChatRoomTextFieldWidgetState
    extends State<OpenChatRoomTextFieldWidget> {
  late TextEditingController _tec;

  @override
  void initState() {
    super.initState();
    _tec = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _tec.dispose();
  }

  void _handleSubmit() {
    final content = _tec.text.trim();
    if (content.isEmpty) {
      return;
    }
    context.read<OpenChatBloc>().add(
        SendOpenChatMessageEvent(content: content, chatId: widget._chatId));
    _tec.clear();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: _tec,
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(decorationThickness: 0),
        minLines: 1,
        maxLines: 3,
        maxLength: 1000,
        decoration: InputDecoration(
            border: const OutlineInputBorder(),
            counterText: "",
            suffixIcon: GestureDetector(
                onTap: _handleSubmit, child: _SendButton(_handleSubmit))));
  }
}

class _SendButton extends StatelessWidget {
  const _SendButton(this.callback, {super.key});

  final void Function() callback;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OpenChatBloc, OpenChatState>(builder: (context, state) {
      switch (state.status) {
        case Status.initial:
        case Status.success:
          return GestureDetector(
              onTap: callback,
              child: Icon(Icons.send,
                  color: Theme.of(context).colorScheme.primary));
        case Status.loading:
        case Status.error:
          return const CircularProgressIndicator();
      }
    });
  }
}
