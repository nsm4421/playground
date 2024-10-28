part of 'page.dart';

class EditorHashtagFragment extends StatelessWidget {
  const EditorHashtagFragment({super.key});

  static const _maxHashtagNum = 5;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditFeedBloc, EditFeedState>(
        builder: (context, state) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          const Icon(Icons.tag),
          const SizedBox(width: 12),
          Text('Hashtag',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const Spacer(),

          /// 모달창 띄우기 버튼
          if (state.hashtags.length < _maxHashtagNum)
            GestureDetector(
                onTap: () async {
                  await showModalBottomSheet(
                          context: context,
                          builder: (_) => EditHashtagWidget(state.hashtags))
                      .then((res) {
                    if (res == null || res.isEmpty) return;
                    // 해시태그 업데이트
                    context.read<EditFeedBloc>().add(UpdateEditorEvent(
                        location: state.location,
                        hashtags: [...state.hashtags, res]));
                  });
                },
                child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            Theme.of(context).colorScheme.secondaryContainer),
                    child: Icon(Icons.add,
                        size: 25,
                        color: Theme.of(context).colorScheme.secondary)))
        ]),

        /// 해시태그 목록
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
                    Text(item, style: Theme.of(context).textTheme.labelLarge),
                    IconButton(

                        /// 해시태그 삭제 버튼
                        onPressed: () {
                          final List<String> hashtags = [...state.hashtags];
                          hashtags.removeAt(index);
                          context.read<EditFeedBloc>().add(UpdateEditorEvent(
                              location: state.location, hashtags: hashtags));
                        },
                        icon: const Icon(Icons.delete_forever))
                  ]));
        }))
      ]);
    });
  }
}

class EditHashtagWidget extends StatefulWidget {
  const EditHashtagWidget(this.hashtags, {super.key});

  final List<String> hashtags;

  @override
  State<EditHashtagWidget> createState() => _EditTextWidgetState();
}

class _EditTextWidgetState extends State<EditHashtagWidget> {
  static const int _maxLength = 30;
  late TextEditingController _textEditingController;
  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _formKey = GlobalKey(debugLabel: 'edit-diary-hashtag');
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  String? _handleValidate(String? text) {
    if (text == null || text.isEmpty) {
      return 'press text';
    } else if (widget.hashtags.contains(text)) {
      return 'duplicated hashtag!';
    } else {
      return null;
    }
  }

  _handleAddHashtag() {
    final ok = _formKey.currentState?.validate();
    if (ok == null || !ok) return;
    _formKey.currentState?.save();
    context.pop<String>(_textEditingController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context)
          .viewInsets
          .copyWith(top: 12, left: 8, right: 8),
      child: Form(
        key: _formKey,
        child: TextFormField(
          controller: _textEditingController,
          validator: _handleValidate,
          maxLines: 1,
          maxLength: _maxLength,
          decoration: InputDecoration(
              prefixIcon: const Icon(Icons.tag),
              suffixIcon: IconButton(
                icon: const Icon(Icons.add),
                onPressed: _handleAddHashtag,
              ),
              border: const UnderlineInputBorder()),
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                letterSpacing: 1.5,
                decorationThickness: 0,
                fontWeight: FontWeight.w700,
              ),
        ),
      ),
    );
  }
}
