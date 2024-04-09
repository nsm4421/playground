import 'package:flutter/material.dart';

class HashtagListWidget extends StatelessWidget {
  const HashtagListWidget(this.hashtags, {super.key});

  final List<String> hashtags;

  @override
  Widget build(BuildContext context) => Container(
      alignment: Alignment.topLeft,
      child: Wrap(
          children: hashtags
              .map((text) => Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).colorScheme.secondaryContainer),
                  child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(Icons.tag,
                                size: 25,
                                color: Theme.of(context).colorScheme.secondary),
                            Text(text,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(fontWeight: FontWeight.w800))
                          ]))))
              .toList()));
}
