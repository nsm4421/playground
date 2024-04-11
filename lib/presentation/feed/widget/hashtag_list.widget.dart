import 'package:flutter/material.dart';

class HashtagListWidget extends StatelessWidget {
  const HashtagListWidget(this.hashtags, {super.key, this.handleDelete});

  final List<String> hashtags;
  final void Function(String text)? handleDelete;

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
                                size: 20,
                                color: Theme.of(context).colorScheme.secondary),
                            const SizedBox(width: 5),
                            Text(text,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                        fontWeight: FontWeight.w800,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary)),
                            // 삭제 버튼
                            if (handleDelete != null)
                              IconButton(
                                  onPressed: () {
                                    handleDelete!(text);
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    size: 18,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ))
                          ]))))
              .toList()));
}
