part of 'page.dart';

class HashtagFragment extends StatefulWidget {
  const HashtagFragment({super.key});

  @override
  State<HashtagFragment> createState() => _HashtagFragmentState();
}

class _HashtagFragmentState extends State<HashtagFragment> {
  late TextEditingController _hashtagTec;

  @override
  void initState() {
    super.initState();
    _hashtagTec = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _hashtagTec.dispose();
  }

  _handleAddHashtag() {
    final text = _hashtagTec.text.trim();
    if (text.isEmpty) return;
    final hashtags = context.read<CreateMeetingCubit>().state.hashtags;
    if (hashtags.contains(text)) {
      customUtil.showWarningSnackBar(
          context: context, message: 'duplicated hashtag');
      return;
    }
    _hashtagTec.clear();
    context
        .read<CreateMeetingCubit>()
        .updateState(hashtags: [...hashtags, text]);
  }

  _handleDeleteHashtag(int index) => () {
        List<String> hashtags = [
          ...context.read<CreateMeetingCubit>().state.hashtags
        ];
        hashtags.removeAt(index);
        context.read<CreateMeetingCubit>().updateState(hashtags: hashtags);
      };

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateMeetingCubit, CreateMeetingState>(
        builder: (context, state) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          const Icon(Icons.tag_sharp),
          const SizedBox(width: 12),
          Text('Hashtag',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold))
        ]),
        // 해시태그 추가 버튼
        TextField(
            controller: _hashtagTec,
            decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: _handleAddHashtag,
                    icon: const Icon(Icons.add)))),
        const SizedBox(height: 12),

        // 해시태그 목록
        Wrap(
            children: List.generate(state.hashtags.length, (index) {
          final item = state.hashtags[index];
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
                    const SizedBox(width: 8),
                    Text(item,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).colorScheme.secondary)),
                    IconButton(
                        icon: Icon(Icons.clear,
                            color: Theme.of(context).colorScheme.secondary),
                        onPressed: _handleDeleteHashtag(index))
                  ]));
        }))
      ]);
    });
  }
}
