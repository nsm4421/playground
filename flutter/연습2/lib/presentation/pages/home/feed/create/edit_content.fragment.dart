part of '../../../export.pages.dart';

class EditContentFragment extends StatefulWidget {
  const EditContentFragment({super.key});

  @override
  State<EditContentFragment> createState() => _EditContentFragmentState();
}

class _EditContentFragmentState extends State<EditContentFragment> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  static const int _maxLength = 5000;
  static const int _minLine = 5;
  static const int _maxLine = 20;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode()..addListener(_onFocusLeave);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _focusNode
      ..removeListener(_onFocusLeave)
      ..dispose();
  }

  _onFocusLeave() {
    context.read<CreateFeedCubit>().updateContent(_controller.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: TextField(
            controller: _controller,
            focusNode: _focusNode,
            minLines: _minLine,
            maxLines: _maxLine,
            maxLength: _maxLength,
            style: context.textTheme.bodyLarge?.copyWith(letterSpacing: 1.5),
            decoration: const InputDecoration(
              hintText: "Content",
              border: OutlineInputBorder(),
            ),
          ),
        )
      ],
    );
  }
}
