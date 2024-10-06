part of '../index.page.dart';

class HashtagsWidget extends StatelessWidget {
  const HashtagsWidget(this.hashtags, {super.key});

  final List<String> hashtags;

  @override
  Widget build(BuildContext context) {
    return Wrap(
        children: List.generate(hashtags.length, (index) {
      final item = hashtags[index];
      return Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          padding: const EdgeInsets.only(left: 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: Theme.of(context).colorScheme.secondaryContainer),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.tag, color: Theme.of(context).colorScheme.secondary),
                Text(item,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.secondary)),
                const SizedBox(width: 8)
              ]));
    }));
  }
}
