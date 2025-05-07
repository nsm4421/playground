part of "create_feed.page.dart";

class CreateFeedScreen extends StatefulWidget {
  const CreateFeedScreen({super.key});

  @override
  State<CreateFeedScreen> createState() => _CreateFeedScreenState();
}

class _CreateFeedScreenState extends State<CreateFeedScreen> {
  static const _maxHashtagNum = 5;
  static const _maxMediaNum = 5;
  late ImagePicker _picker;
  late TextEditingController _contentTec;
  late TextEditingController _hashtagTec;
  late GlobalKey<FormState> _contentFormKey;
  late GlobalKey<FormState> _hashtagFormKey;
  final List<XFile> _xFiles = [];
  final List<String> _hashtags = [];

  @override
  void initState() {
    super.initState();
    _contentFormKey = GlobalKey<FormState>();
    _hashtagFormKey = GlobalKey<FormState>();
    _picker = ImagePicker();
    _contentTec = TextEditingController();
    _hashtagTec = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _contentTec.dispose();
    _hashtagTec.dispose();
  }

  _handleSubmit() {
    _contentFormKey.currentState?.save();
    _hashtagFormKey.currentState?.save();
    final ok = _contentFormKey.currentState?.validate();
    if (ok == null || !ok) {
      return;
    }
    context.read<CreateFeedCubit>().submit(
        content: _contentTec.text.trim(),
        hashtags: _hashtags,
        files: _xFiles.map((xFile) => File(xFile.path)).toList());
  }

  _handleSelectMedia() async {
    await _picker.pickMultiImage(imageQuality: 90).then((res) {
      setState(() {
        if (_xFiles.length + res.length > _maxMediaNum) {
          _xFiles.addAll(res.getRange(0, _maxHashtagNum - _xFiles.length));
          Fluttertoast.showToast(msg: 'Too Many Images');
        } else {
          _xFiles.addAll(res);
        }
      });
    });
  }

  _handleUnSelectMedia(index) => () {
        setState(() {
          _xFiles.removeAt(index);
        });
      };

  String? _handleValidateContent(String? text) {
    if (text == null || text.isEmpty) {
      return "Press Content";
    }
    return null;
  }

  String? _handleValidateHashtag(String? text) {
    if (text == null || text.isEmpty) {
      return "Send Hashtag";
    } else if (_hashtags.length >= _maxHashtagNum) {
      return "Too Many Hashtag";
    } else if (_hashtags.contains(text)) {
      return "Duplicated Hashtag";
    } else {
      return null;
    }
  }

  _handleAddHashtag() {
    final ok = _hashtagFormKey.currentState?.validate();
    if (ok != null && ok) {
      setState(() {
        _hashtags.add(_hashtagTec.text.trim());
        _hashtagTec.clear();
      });
    }
  }

  _handleDeleteHashtag(String text) {
    setState(() {
      _hashtags.remove(text);
    });
  }

  _handlePop() {
    context.pop(null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Feed"),
        actions: [
          GestureDetector(
            onTap: _handleSubmit,
            child: Container(
              margin: const EdgeInsets.only(right: 8.0),
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).colorScheme.primaryContainer),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.upload),
                  const SizedBox(width: 8),
                  Text(
                    "UPLOAD",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimary),
                  )
                ],
              ),
            ),
          ),
        ],
        leading:
            IconButton(onPressed: _handlePop, icon: const Icon(Icons.clear)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 본문
            Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        Icon(Icons.abc,
                            color: Theme.of(context).colorScheme.primary),
                        const SizedBox(width: 5),
                        Text("Content",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary))
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: _contentFormKey,
                        child: TextFormField(
                          validator: _handleValidateContent,
                          minLines: 3,
                          maxLines: 10,
                          maxLength: 1000,
                          style: const TextStyle(decorationThickness: 0),
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              counterStyle: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary)),
                          controller: _contentTec,
                        ),
                      ),
                    )
                  ],
                )),

            const Divider(),

            // 해시태그
            Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.tag,
                                color: Theme.of(context).colorScheme.primary),
                            const SizedBox(width: 5),
                            Text("Hashtag",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary)),
                          ],
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Form(
                            key: _hashtagFormKey,
                            child: TextFormField(
                                validator: _handleValidateHashtag,
                                style: const TextStyle(decorationThickness: 0),
                                decoration: InputDecoration(
                                    suffixIcon:
                                        _hashtags.length < _maxHashtagNum
                                            ? IconButton(
                                                icon: Icon(Icons.add,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .tertiary),
                                                onPressed: _handleAddHashtag)
                                            : null),
                                controller: _hashtagTec),
                          )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: HashtagsWidget(_hashtags,
                            onDelete: _handleDeleteHashtag),
                      )
                    ])),

            const Divider(),

            /// 사진
            Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(mainAxisSize: MainAxisSize.min, children: [
                            Icon(Icons.photo_outlined,
                                color: Theme.of(context).colorScheme.primary),
                            const SizedBox(width: 5),
                            Text("Media",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary)),
                            const Spacer(),
                            IconButton(
                                onPressed: _handleSelectMedia,
                                icon: Icon(Icons.add_a_photo_outlined,
                                    color:
                                        Theme.of(context).colorScheme.primary)),
                          ])),

                      // 미리보기
                      if (_xFiles.isNotEmpty)
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              ...List.generate(_xFiles.length, (index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Stack(
                                    children: [
                                      CircleAvatar(
                                          radius: 45,
                                          backgroundImage: FileImage(
                                              File(_xFiles[index].path))),
                                      Positioned(
                                          top: -15,
                                          right: -15,
                                          child: IconButton(
                                              onPressed:
                                                  _handleUnSelectMedia(index),
                                              iconSize: 20,
                                              icon: Icon(Icons.clear,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary))),
                                    ],
                                  ),
                                );
                              })
                            ],
                          ),
                        )
                    ]))
          ],
        ),
      ),
    );
  }
}
