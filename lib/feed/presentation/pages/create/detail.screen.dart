part of 'create_feed.page.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late TextEditingController _tec;
  late FocusNode _focusNode;

  static const _maxLength = 1000;

  @override
  initState() {
    super.initState();
    _tec = TextEditingController();
    _focusNode = FocusNode()..addListener(_focusNodeListener);
  }

  @override
  dispose() {
    super.dispose();
    _tec.dispose();
    _focusNode
      ..removeListener(_focusNodeListener)
      ..dispose();
  }

  _focusNodeListener() {
    if (!_focusNode.hasFocus) {
      context.read<CreateFeedBloc>().add(UpdateStateEvent(caption: _tec.text));
    }
  }

  _moveBack() {
    context
        .read<CreateFeedBloc>()
        .add(UpdateStateEvent(step: CreateMediaStep.selectMedia));
  }

  _showAddHashtag() async {
    await showModalBottomSheet<List<String>?>(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(CustomSpacing.md),
          topRight: Radius.circular(CustomSpacing.md),
        )),
        showDragHandle: false,
        context: context,
        builder: (_) => AddHashtagFragment(
            context.read<CreateFeedBloc>().state.hashtags)).then((hashtags) {
      if (hashtags == null) return;
      setState(() {
        context
            .read<CreateFeedBloc>()
            .add(UpdateStateEvent(hashtags: hashtags));
      });
    });
  }

  _uploadFeed() {
    if (_tec.text.trim().isEmpty) {
      getIt<CustomSnakbar>().error(title: '캡션을 입력해주세요');
      return;
    }
    context.read<CreateFeedBloc>().add(UploadEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: _moveBack, icon: const Icon(Icons.chevron_left)),
          title: const Text('포스팅을 작성해주세요')),
      body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CustomHeight.xl,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage:
                  FileImage(context.read<CreateFeedBloc>().state.media!),
            ),
            CustomWidth.sm,
            Expanded(
              child: Column(
                children: [
                  CustomHeight.sm,
                  TextField(
                    controller: _tec,
                    focusNode: _focusNode,
                    maxLength: _maxLength,
                    minLines: 3,
                    maxLines: 10,
                    decoration: const InputDecoration(hintText: '피드를 작성해주세요'),
                  ),
                ],
              ),
            ),
          ],
        ),
        Padding(
            padding: EdgeInsets.only(
              top: CustomSpacing.lg,
              left: CustomSpacing.sm,
              right: CustomSpacing.sm,
            ),
            child: context.read<CreateFeedBloc>().state.hashtags.isEmpty
                // 해시태그 수정화면 띄우기 버튼
                ? IconButton(
                    onPressed: _showAddHashtag,
                    icon: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.tag_outlined,
                          size: CustomTextSize.xl,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                        Text('해시태그 추가하기',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.tertiary,
                                ))
                      ],
                    ))
                // 해시태그 아이템 목록
                : Wrap(
                    children: context
                        .read<CreateFeedBloc>()
                        .state
                        .hashtags
                        .map((text) => GestureDetector(
                              onTap: _showAddHashtag,
                              child: Container(
                                margin: EdgeInsets.only(
                                    right: CustomSpacing.lg,
                                    top: CustomSpacing.tiny),
                                padding: EdgeInsets.symmetric(
                                    horizontal: CustomSpacing.sm,
                                    vertical: CustomSpacing.tiny),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(CustomSpacing.sm),
                                    color: Theme.of(context)
                                        .colorScheme
                                        .tertiaryContainer),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.tag,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary),
                                      CustomWidth.tiny,
                                      Text(
                                        text,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimary),
                                      )
                                    ]),
                              ),
                            ))
                        .toList(),
                  ))
      ])),

      // 피드 제출 버튼
      floatingActionButton: FloatingActionButton.small(
        onPressed: _uploadFeed,
        child: Icon(
          Icons.check,
          size: CustomTextSize.xl,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
