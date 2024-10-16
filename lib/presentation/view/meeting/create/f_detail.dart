part of 'page.dart';

class DetailFragment extends StatefulWidget {
  const DetailFragment({super.key});

  @override
  State<DetailFragment> createState() => _DetailFragmentState();
}

class _DetailFragmentState extends State<DetailFragment> {
  static const int _titleLine = 1;
  static const int _contentMinLine = 3;
  static const int _contentMaxLine = 10;
  static const int _titleMaxLength = 50;
  static const int _contentMaxLength = 1000;
  late TextEditingController _titleTec;
  late TextEditingController _contentTec;
  late TextEditingController _hashtagTec;

  @override
  void initState() {
    super.initState();
    _titleTec = TextEditingController();
    _contentTec = TextEditingController();
    _hashtagTec = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _titleTec.dispose();
    _contentTec.dispose();
    _hashtagTec.dispose();
  }

  _handleClearTitle() {
    _titleTec.clear();
    context.read<CreateMeetingCubit>().updateState(title: '');
  }

  _handleShowTitleModal() async {
    await showModalBottomSheet(
        showDragHandle: true,
        context: context,
        builder: (_) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: TextField(
              controller: _titleTec,
              minLines: _titleLine,
              maxLines: _titleLine,
              maxLength: _titleMaxLength,
              decoration: const InputDecoration(labelText: 'TITLE'),
            ),
          );
        }).then((_) {
      context
          .read<CreateMeetingCubit>()
          .updateState(title: _titleTec.text.trim());
    });
  }

  _handleShowContentModal() async {
    await showModalBottomSheet(
        showDragHandle: true,
        context: context,
        builder: (_) {
          return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: TextField(
                  controller: _contentTec,
                  minLines: _contentMinLine,
                  maxLines: _contentMaxLine,
                  maxLength: _contentMaxLength,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'CONTENT')));
        }).then((_) {
      context
          .read<CreateMeetingCubit>()
          .updateState(content: _contentTec.text.trim());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      // 제목
      Column(children: [
        Row(children: [
          const Icon(Icons.title),
          const SizedBox(width: 12),
          Text('Title',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold))
        ]),
        const SizedBox(height: 10),
        TextField(
            controller: _titleTec,
            onTap: _handleShowTitleModal,
            readOnly: true,
            decoration: InputDecoration(
                suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: _handleClearTitle)))
      ]),

      // 본문
      Column(children: [
        const SizedBox(height: 24),
        Row(children: [
          const Icon(Icons.abc),
          const SizedBox(width: 12),
          Text('Content',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold))
        ]),
        const SizedBox(height: 10),
        TextField(
            controller: _contentTec,
            onTap: _handleShowContentModal,
            minLines: _contentMinLine,
            maxLines: _contentMaxLine,
            decoration: const InputDecoration(border: OutlineInputBorder()),
            readOnly: true)
      ])
    ]);
  }
}
