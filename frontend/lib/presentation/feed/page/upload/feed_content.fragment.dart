import 'package:flutter/material.dart';

class FeedContentFragment extends StatelessWidget {
  const FeedContentFragment(this._textEditingController, {super.key});

  static const int _maxLength = 1000;

  final TextEditingController _textEditingController;

  _handleClear() {
    _textEditingController.clear();
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Row(
            children: [
              const Icon(Icons.book_outlined),
              const SizedBox(width: 5),
              Text("CONTENT",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.w700)),
              const Spacer(),
              IconButton(onPressed: _handleClear, icon: const Icon(Icons.clear))
            ],
          ),
          TextField(
            decoration: const InputDecoration(
                hintText: "본문", border: OutlineInputBorder()),
            maxLength: _maxLength,
            minLines: 1,
            maxLines: 20,
            controller: _textEditingController,
          ),
        ],
      );
}
