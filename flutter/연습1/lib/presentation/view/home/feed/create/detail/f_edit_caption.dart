part of '../index.dart';

class EditCaptionFragment extends StatefulWidget {
  const EditCaptionFragment(this.initText, {super.key});

  final String? initText;

  @override
  State<EditCaptionFragment> createState() => _EditCaptionFragmentState();
}

class _EditCaptionFragmentState extends State<EditCaptionFragment> {
  late TextEditingController _controller;

  static const int _maxLength = 50;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initText);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  _handleClear() {
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.pop<String?>(_controller.text);
        return false;
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
        child: TextField(
          controller: _controller,
          minLines: 1,
          maxLines: 5,
          maxLength: _maxLength,
          decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'Caption',
              suffixIcon: IconButton(
                icon: Icon(Icons.clear),
                onPressed: _handleClear,
              )),
        ),
      ),
    );
  }
}
