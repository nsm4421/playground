import 'package:flutter/material.dart';

class ContentFragment extends StatelessWidget {
  const ContentFragment(this._tec, {super.key});

  final TextEditingController _tec;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text("Content",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: Theme.of(context).colorScheme.primary)),
            TextFormField(
              controller: _tec,
              minLines: 1,
              maxLines: 20,
              decoration: const InputDecoration(border: InputBorder.none),
              maxLength: 1000,
            )
          ],
        ),
      );
}
