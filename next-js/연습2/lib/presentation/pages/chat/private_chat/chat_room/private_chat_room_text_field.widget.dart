part of "private_chat_room.page.dart";

class PrivateChatRoomTextFieldWidget extends StatefulWidget {
  const PrivateChatRoomTextFieldWidget(this.receiverUid, {super.key});

  final String receiverUid;

  @override
  State<PrivateChatRoomTextFieldWidget> createState() =>
      _PrivateChatRoomTextFieldWidgetState();
}

class _PrivateChatRoomTextFieldWidgetState
    extends State<PrivateChatRoomTextFieldWidget> {
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
    context.read<PrivateChatRoomBloc>().add(SendPrivateChatMessageEvent(
        content: content, receiver: widget.receiverUid));
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
    return BlocBuilder<PrivateChatRoomBloc, PrivateChatRoomState>(
        builder: (context, state) {
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
