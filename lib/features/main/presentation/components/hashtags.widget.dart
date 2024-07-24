import 'package:flutter/material.dart';

class HashtagsWidget extends StatelessWidget {
  const HashtagsWidget(this.hashtags,
      {super.key, this.onDelete, this.size = 15});

  final List<String> hashtags;
  final void Function(String text)? onDelete;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Wrap(
        children: hashtags
            .map((text) => Container(
                margin: const EdgeInsets.only(right: 5, bottom: 5),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.tag,
                      size: size,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                    Flexible(
                      child: Text(text,
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: size,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSecondary)),
                    ),
                    if (onDelete != null)
                      GestureDetector(
                        onTap: () {
                          onDelete!(text);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Icon(Icons.clear,
                              size: size,
                              color: Theme.of(context).colorScheme.outline),
                        ),
                      )
                  ],
                )))
            .toList());
  }
}
