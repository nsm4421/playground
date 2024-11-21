part of 'widget.dart';

class ExpandableTextWidget extends StatefulWidget {
  const ExpandableTextWidget(this.text,
      {super.key, this.minLine = 3, this.textStyle, this.labelTextStyle});

  final String text;
  final int minLine;
  final TextStyle? textStyle;
  final TextStyle? labelTextStyle;

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  bool _isExpanded = false;
  bool _showToggle = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkTextOverflow();
    });
  }

  void _checkTextOverflow() {
    final textSpan = TextSpan(text: widget.text, style: const TextStyle());
    final textPainter = TextPainter(
        text: textSpan,
        maxLines: widget.minLine,
        textDirection: TextDirection.ltr);
    textPainter.layout(maxWidth: MediaQuery.of(context).size.width);
    setState(() {
      _showToggle = textPainter.didExceedMaxLines;
    });
  }

  _handleSwitchExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          maxLines: _isExpanded ? null : widget.minLine,
          overflow: _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
          style: widget.textStyle ?? context.textTheme.bodyMedium,
        ),
        (8.0).h,
        if (_showToggle)
          GestureDetector(
            onTap: _handleSwitchExpand,
            child: Text(
              _isExpanded ? "Collapse" : "Expand",
              style: widget.labelTextStyle ??
                  context.textTheme.titleSmall?.copyWith(
                    color: CustomPalette.positive,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          )
      ],
    );
  }
}
