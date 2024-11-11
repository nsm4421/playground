part of '../index.dart';

class ContentFragment extends StatefulWidget {
  const ContentFragment({super.key});

  @override
  State<ContentFragment> createState() => _ContentFragmentState();
}

class _ContentFragmentState extends State<ContentFragment> {
  late String _initText;
  late TextEditingController _controller;
  static const _maxLength = 500;
  static const _minLine = 3;
  static const _maxLine = 10;

  @override
  void initState() {
    super.initState();
    _initText = context.read<CreateFeedBloc>().state.content;
    _controller = TextEditingController(text: _initText);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  _handleOnChange(String text) {
    context
        .read<CreateFeedBloc>()
        .add(InitEvent(content: _controller.text.trim()));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.abc),
            (12.0).w,
            Text(
              'Content',
              style: context.textTheme.titleSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        (12.0).h,
        TextField(
          controller: _controller,
          maxLength: _maxLength,
          minLines: _minLine,
          maxLines: _maxLine,
          onChanged: _handleOnChange,
          decoration: InputDecoration(
            counterStyle: context.textTheme.labelMedium?.copyWith(
              color: CustomPalette.mediumGrey.withOpacity(0.5),
            ),
            border: const OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
