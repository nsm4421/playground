import 'package:flutter/material.dart';

class FeedItemContentWidget extends StatelessWidget {
  const FeedItemContentWidget({super.key, required this.content, required this.hashtags});

  final String content;
  final List<String> hashtags;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      const SizedBox(width: 15),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            content,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          if (hashtags.isNotEmpty) Row(
            children: hashtags
                .map((hashtag) => Row(
              children: [
                Text("#$hashtag",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent)),
                const SizedBox(width: 8)
              ],
            ))
                .toList(),
          )
        ],
      ),
      const SizedBox(width: 15),
    ],
  );
}