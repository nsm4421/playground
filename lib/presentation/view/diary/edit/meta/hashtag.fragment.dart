part of '../edit_diary.page.dart';

class HashtagFragment extends StatelessWidget {
  const HashtagFragment({super.key});

  static const _maxHashtagNum = 5;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditDiaryBloc, EditDiaryState>(
        builder: (context, state) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            Text('해새태그를 추가하시겠습니까?',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(color: Theme.of(context).colorScheme.tertiary)),
            const Spacer(),

            /// 모달창 띄우기 버튼
            if (state.hashtags.length < _maxHashtagNum)
              ElevatedButton(
                  onPressed: () async {
                    await showModalBottomSheet(
                            context: context,
                            builder: (_) => EditHashtagWidget(state.hashtags))
                        .then((res) {
                      if (res == null || res.isEmpty) return;
                      // 해시태그 업데이트
                      context.read<EditDiaryBloc>().add(UpdateMetaDataEvent(
                          location: state.location,
                          hashtags: [...state.hashtags, res]));
                    });
                  },
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    const Icon(Icons.tag, size: 20),
                    const SizedBox(width: 8),
                    Text('Add Tag',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith())
                  ]))
          ],
        ),

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
                          context.read<EditDiaryBloc>().add(UpdateMetaDataEvent(
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
      return '텍스트를 입력해주세요';
    } else if (widget.hashtags.contains(text)) {
      return '중복된 해시태그 입니다';
    } else {
      return null;
    }
  }

  _handleAddHashtag() {
    final ok = _formKey.currentState?.validate();
    if (ok == null || !ok) return;
    _formKey.currentState?.save();
    context.pop(_textEditingController.text.trim());
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
