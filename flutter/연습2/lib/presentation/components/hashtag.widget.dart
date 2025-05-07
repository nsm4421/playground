part of 'export.components.dart';

class HashtagListWidget extends StatelessWidget {
  const HashtagListWidget(
      {super.key, required this.hashtags, this.handleDelete});

  final List<String> hashtags;
  final void Function() Function(int index)? handleDelete;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List.generate(hashtags.length, (index) {
        final text = hashtags[index];
        return Container(
          margin: const EdgeInsets.only(left: 8, top: 8),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.tag, size: 14),
              (6.width),
              Text(
                text,
                style: context.textTheme.labelLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              if (handleDelete != null) (3.width),
              if (handleDelete != null)
                IconButton(
                    onPressed: handleDelete!(index),
                    icon: const Icon(Icons.delete_outline))
            ],
          ),
        );
      }),
    );
  }
}
