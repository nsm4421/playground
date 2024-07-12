part of 'open_chat_room.page.dart';

class OpenChatTextFieldWidget extends StatefulWidget {
  const OpenChatTextFieldWidget({super.key});

  @override
  State<OpenChatTextFieldWidget> createState() =>
      _OpenChatTextFieldWidgetState();
}

class _OpenChatTextFieldWidgetState extends State<OpenChatTextFieldWidget> {
  static const int _maxLength = 1000;
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

  _handleSubmit() {
    final content = _tec.text.trim();
    context.read<SendOpenChatMessageCubit>().send(content);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SendOpenChatMessageCubit, SendOpenChatMessageState>(
      listener: (BuildContext context, SendOpenChatMessageState state) {
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
      child: BlocBuilder<SendOpenChatMessageCubit, SendOpenChatMessageState>(
          builder: (context, state) {
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
                        icon: const Icon(Icons.send), onPressed: _handleSubmit))
                : const InputDecoration(
                    counterText: '',
                    border: OutlineInputBorder(),
                    suffixIcon: Center(
                        heightFactor: 1,
                        widthFactor: 1,
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 3),
                        ))));
      }),
    );
  }
}
