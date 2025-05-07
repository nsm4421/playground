part of 'index.dart';

class EditCaptionFragment extends StatefulWidget {
  const EditCaptionFragment({super.key});

  @override
  State<EditCaptionFragment> createState() => _EditCaptionFragmentState();
}

class _EditCaptionFragmentState extends State<EditCaptionFragment> {
  static const int _maxLength = 30;

  late TextEditingController _controller;
  late FocusNode _focusNode;

  String? _helperText;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
        text: context.read<CreateReelsBloc>().state.caption);
    _focusNode = FocusNode(debugLabel: 'create-reels-caption')
      ..addListener(_handleEditCaption);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _focusNode
      ..removeListener(_handleEditCaption)
      ..dispose();
  }

  _handleChange(String text) {
    setState(() {
      _helperText = text.length >= _maxLength
          ? 'maximum character is $_maxLength  (${text.length}/$_maxLength)'
          : null;
    });
  }

  _handleEditCaption() {
    if (!_focusNode.hasFocus) {
      context
          .read<CreateReelsBloc>()
          .add(EditCaptionEvent(_controller.text.trim()));
    }
  }

  _handleClear() {
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: TextField(
        onChanged: _handleChange,
        decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: 'caption',
            hintStyle: context.textTheme.labelMedium,
            counterText: '',
            helperText: _helperText,
            helperStyle: context.textTheme.labelLarge
                ?.copyWith(color: context.colorScheme.error),
            suffixIcon: IconButton(
                onPressed: _handleClear, icon: const Icon(Icons.clear))),
        style: context.textTheme.bodyMedium,
        focusNode: _focusNode,
        controller: _controller,
        maxLength: _maxLength,
        minLines: 1,
        maxLines: 2,
      ),
    );
  }
}
