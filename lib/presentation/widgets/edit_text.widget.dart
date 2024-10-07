part of 'widgets.dart';

class EditTextWidget extends StatefulWidget {
  const EditTextWidget(
      {super.key,
      required this.initialText,
      this.prefixIcon,
      this.suffixIcon,
      this.minLine = 3,
      this.maxLine = 10,
      this.maxLength = 1000});

  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String initialText;
  final int minLine;
  final int maxLine;
  final int maxLength;

  @override
  State<EditTextWidget> createState() => _EditTextWidgetState();
}

class _EditTextWidgetState extends State<EditTextWidget> {
  late TextEditingController _tec;

  @override
  void initState() {
    super.initState();
    _tec = TextEditingController()..text = widget.initialText;
  }

  @override
  void dispose() {
    super.dispose();
    _tec.dispose();
  }

  Future<bool> _handlePop() async {
    context.pop<String?>(_tec.text);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _handlePop,
      child: Padding(
        padding: MediaQuery.of(context)
            .viewInsets
            .copyWith(top: 12, left: 8, right: 8),
        child: TextField(
          controller: _tec,
          minLines: widget.minLine,
          maxLines: widget.maxLine,
          maxLength: widget.maxLength,
          decoration: InputDecoration(
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.suffixIcon,
              border: const OutlineInputBorder()),
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
