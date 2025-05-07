import 'package:flutter/material.dart';

class HashtagsWidget extends StatelessWidget {
  const HashtagsWidget(this.hashtags,
      {super.key,
      this.onDelete,
      this.size = 15,
      this.bgColor,
      this.textColor,
      this.iconColor});

  final List<String> hashtags;
  final void Function(String text)? onDelete;
  final double size;
  final Color? bgColor;
  final Color? textColor;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Wrap(
        children: hashtags
            .map((text) => Container(
                margin: const EdgeInsets.only(right: 5, bottom: 5),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                    color: bgColor ??
                        Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.tag,
                      size: size,
                      color:
                          iconColor ?? Theme.of(context).colorScheme.onPrimary,
                    ),
                    Flexible(
                      child: Text(text,
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: size,
                                  color: textColor ??
                                      Theme.of(context).colorScheme.onPrimary)),
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
                              color: iconColor ??
                                  Theme.of(context).colorScheme.outline),
                        ),
                      )
                  ],
                )))
            .toList());
  }
}
