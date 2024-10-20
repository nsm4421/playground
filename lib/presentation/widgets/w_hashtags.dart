part of 'widgets.dart';

class DisplayHashtagsWidget extends StatelessWidget {
  const DisplayHashtagsWidget(this.hashtags,
      {super.key, this.color, this.bgColor});

  final List<String> hashtags;
  final Color? color;
  final Color? bgColor;

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
              color:
                  bgColor ?? Theme.of(context).colorScheme.secondaryContainer),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.tag,
                    color: color ?? Theme.of(context).colorScheme.secondary),
                Text(item,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color:
                            color ?? Theme.of(context).colorScheme.secondary)),
                const SizedBox(width: 8)
              ]));
    }));
  }
}

class EditHashtagsWidget extends StatelessWidget {
  const EditHashtagsWidget(
      {super.key,
      required this.hashtags,
      required this.setHashtags,
      this.color,
      this.bgColor});

  final List<String> hashtags;
  final Function(List<String> hashtags) setHashtags;
  final Color? color;
  final Color? bgColor;

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
              color:
                  bgColor ?? Theme.of(context).colorScheme.secondaryContainer),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.tag,
                    color: color ?? Theme.of(context).colorScheme.secondary),
                Text(item,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color:
                            color ?? Theme.of(context).colorScheme.secondary)),
                const SizedBox(width: 8),
                // 취소버튼
                IconButton(
                    icon: Icon(Icons.clear,
                        color:
                            color ?? Theme.of(context).colorScheme.secondary),
                    onPressed: () {
                      final newHashtags = [...hashtags];
                      newHashtags.removeAt(index);
                      setHashtags(newHashtags);
                    })
              ]));
    }));
  }
}
