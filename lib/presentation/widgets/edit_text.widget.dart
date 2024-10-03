part of 'widgets.dart';

class EditTextWidget extends StatefulWidget {
  const EditTextWidget(
      {super.key,
      required this.initialText,
      this.minLine = 3,
      this.maxLine = 10,
      this.maxLength = 1000});

  final String initialText;
  final int minLine;
  final int maxLine;
  final int maxLength;

  @override
  State<EditTextWidget> createState() => _EditTextWidgetState();
}

class _EditTextWidgetState extends State<EditTextWidget> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController()..text = widget.initialText;
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, _textEditingController.text);
        return true;
      },
      child: Padding(
        padding: MediaQuery.of(context).viewInsets.copyWith(left: 8, right: 8),
        child: TextField(
          controller: _textEditingController,
          minLines: widget.minLine,
          maxLines: widget.maxLine,
          maxLength: widget.maxLength,
          decoration: const InputDecoration(border: OutlineInputBorder()),
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                letterSpacing: 1.5,
                decorationThickness: 0,
                fontWeight: FontWeight.w700,
              ),
        ),
      ),
    );
  }
}
