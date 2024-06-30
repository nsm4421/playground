part of 'private_chat.page.dart';

class PrivateChatTextField extends StatefulWidget {
  const PrivateChatTextField(this._opponent, {super.key});

  final AccountEntity _opponent;

  @override
  State<PrivateChatTextField> createState() => _PrivateChatTextFieldState();
}

class _PrivateChatTextFieldState extends State<PrivateChatTextField> {
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
    try {
      final content = _tec.text.trim();
      if (content.isEmpty) {
        return;
      }
      final sender =
          (context.read<UserBloc>().state as UserLoadedState).account;
      context
          .read<SendPrivateChatMessageCubit>()
          .send(sender: sender, receiver: widget._opponent, content: content);
      _tec.clear();
    } catch (error) {
      log(error.toString());
      ToastUtil.toast('메세지 전송 실패');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SendPrivateChatMessageCubit,
        SendPrivateChatMessageState>(
      listener: (BuildContext context, SendPrivateChatMessageState state) {
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
      child:
          BlocBuilder<SendPrivateChatMessageCubit, SendPrivateChatMessageState>(
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
