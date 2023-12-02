import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContentTextFieldWidget extends StatelessWidget {
  const ContentTextFieldWidget(this._tec, {super.key});

  final TextEditingController _tec;
  static const int _maxChar = 1000;

  _handleClear() => _tec.clear();

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text("Content",
                  style: GoogleFonts.lobster(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary)),
              const Spacer(),
              IconButton(
                  onPressed: _handleClear, icon: const Icon(Icons.cancel))
            ],
          ),
          const SizedBox(height: 5),
          TextField(
            style: const TextStyle(decorationThickness: 0),
            minLines: 3,
            maxLines: 10,
            maxLength: _maxChar,
            controller: _tec,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                counterStyle: TextStyle(color: Colors.grey)),
          )
        ],
      );
}
