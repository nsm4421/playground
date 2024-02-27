import 'package:flutter/material.dart';

class ContentTextField extends StatefulWidget {
  const ContentTextField(
      {super.key,
      required TextEditingController tec,
      String? label,
      int maxLength = 1000,
      String? placeholder,
      int minLines = 3,
      int maxLines = 10})
      : _tec = tec,
        _maxLength = maxLength,
        _placeholder = placeholder,
        _label = label,
        _minLines = minLines,
        _maxLines = maxLines;

  final String? _label;
  final String? _placeholder;
  final int _maxLength;
  final TextEditingController _tec;
  final int _minLines;
  final int _maxLines;

  @override
  State<ContentTextField> createState() => _ContentTextFieldState();
}

class _ContentTextFieldState extends State<ContentTextField> {
  _clear() => widget._tec.clear();

  @override
  Widget build(BuildContext context) => Column(
        children: [
          if (widget._label != null)
            Column(
              children: [
                Row(children: [
                  Text(widget._label!,
                      style: Theme.of(context).textTheme.titleLarge),
                  const Spacer(),
                  IconButton(onPressed: _clear, icon: const Icon(Icons.clear)),
                  const SizedBox(height: 10),
                ]),
              ],
            ),
          TextField(
            controller: widget._tec,
            maxLength: widget._maxLength,
            minLines: widget._minLines,
            maxLines: widget._maxLines,
            style: const TextStyle(decorationThickness: 0, fontSize: 20),
            decoration: InputDecoration(
                hintText: widget._placeholder,
                border: const OutlineInputBorder(),
                contentPadding: const EdgeInsets.all(5)),
          )
        ],
      );
}
