import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HashtagsTextFieldWidget extends StatefulWidget {
  const HashtagsTextFieldWidget(this._tecList, {super.key});

  final List<TextEditingController> _tecList;

  @override
  State<HashtagsTextFieldWidget> createState() =>
      _HashtagsTextFieldWidgetState();
}

class _HashtagsTextFieldWidgetState extends State<HashtagsTextFieldWidget> {
  static const int _maxChar = 15;

  static const int _maxHashtag = 5;

  void _handleAddHashtag() {
    if (widget._tecList.length < _maxHashtag) {
      setState(() {
        widget._tecList.add(TextEditingController());
      });
    }
  }

  _handleDeleteHashtag(int index) => () => setState(() {
        widget._tecList.removeAt(index);
      });

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text("Hashtag",
                  style: GoogleFonts.lobster(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary)),
              const Spacer(),
              if (widget._tecList.length < _maxHashtag)
                IconButton(
                    onPressed: _handleAddHashtag,
                    icon: Icon(Icons.add_box,
                        color: Theme.of(context).colorScheme.primary)),
            ],
          ),
          const SizedBox(height: 10),
          ...widget._tecList
              .asMap()
              .entries
              .map((entry) => TextField(
                    style: const TextStyle(decorationThickness: 0),
                    maxLines: 1,
                    maxLength: _maxChar,
                    controller: entry.value,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.tag,
                            color: Theme.of(context).colorScheme.primary),
                        suffixIcon: IconButton(
                            onPressed: _handleDeleteHashtag(entry.key),
                            icon: const Icon(Icons.delete, color: Colors.grey)),
                        border: const OutlineInputBorder(),
                        counterStyle: const TextStyle(color: Colors.grey)),
                  ))
              .toList()
        ],
      );
}
