part of 'index.dart';

class ContentFormWidget extends StatefulWidget {
  const ContentFormWidget({super.key});

  @override
  State<ContentFormWidget> createState() => _ContentFormWidgetState();
}

class _ContentFormWidgetState extends State<ContentFormWidget> {
  late String _initText;
  late TextEditingController _controller;
  late FocusNode _focusNode;
  static const _maxLength = 500;
  static const _minLine = 3;
  static const _maxLine = 10;

  @override
  void initState() {
    super.initState();
    _initText = context.read<CreateFeedBloc>().state.content;
    _controller = TextEditingController(text: _initText);
    _focusNode = FocusNode(debugLabel: 'create-feed-content')
      ..addListener(_handleUnFocus);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _focusNode
      ..removeListener(_handleUnFocus)
      ..dispose();
  }

  _handleUnFocus() {
    if (_focusNode.hasFocus) {
      context
          .read<CreateFeedBloc>()
          .add(InitEvent(content: _controller.text.trim()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      focusNode: _focusNode,
      maxLength: _maxLength,
      minLines: _minLine,
      maxLines: _maxLine,
      decoration: const InputDecoration(hintText: 'content'),
    );
  }
}
