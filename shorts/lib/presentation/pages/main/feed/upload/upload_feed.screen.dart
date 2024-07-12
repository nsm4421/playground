part of 'upload_feed.page.dart';

class UploadFeedScreen extends StatefulWidget {
  const UploadFeedScreen({super.key});

  @override
  State<UploadFeedScreen> createState() => _UploadFeedScreenState();
}

class _UploadFeedScreenState extends State<UploadFeedScreen> {
  static const _maxLengthContent = 500;
  static const _maxLengthHashtag = 30;
  static const _maxLengthCaption = 30;
  static const _maxCountHashtag = 3;

  late GlobalKey<FormState> _formKey;

  late TextEditingController _hashtagTec;

  File? get _file => context.read<UploadFeedCubit>().state.file;

  List<String> get _hashtags => context.read<UploadFeedCubit>().state.hashtags;

  @override
  void initState() {
    super.initState();
    _hashtagTec = TextEditingController();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    super.dispose();
    _hashtagTec.dispose();
  }

  _handleChangeCaption(String v) {
    context.read<UploadFeedCubit>().setCaption(v);
  }

  _handleChangeContent(String v) {
    context.read<UploadFeedCubit>().setContent(v);
  }

  _handleAddHashtag() {
    final newHashtag = _hashtagTec.text.trim();
    if (_hashtags.length >= _maxCountHashtag) {
      ToastUtil.toast('해시태그는 최대 3개까지 작성 가능합니다');
      return;
    } else if (_hashtags.contains(newHashtag)) {
      ToastUtil.toast('중복된 해시태그 입니다');
      return;
    } else {
      context.read<UploadFeedCubit>().setHashtags([..._hashtags, newHashtag]);
      setState(() {});
      _hashtagTec.clear();
    }
  }

  _handleDeleteHashtag(int index) => () {
        final hashtags = [..._hashtags];
        hashtags.removeAt(index);
        context.read<UploadFeedCubit>().setHashtags(hashtags);
        setState(() {});
      };

  _handlePop() {
    if (context.mounted) {
      context.pop();
    }
  }

  String? _handleValidateContent(String? content) {
    if (content == null || content.isEmpty) {
      return "본문을 입력해주세요";
    }
    return null;
  }

  String? _handleValidateCaption(String? caption) {
    if (caption == null || caption.isEmpty) {
      return "캡션을 입력해주세요";
    }
    return null;
  }

  _handleUpload() {
    // Validation
    if (_file == null) {
      ToastUtil.toast('이미지나 동영상을 선택해주세요');
      return;
    } else if (!_formKey.currentState!.validate()) {
      return;
    } else {
      context.read<UploadFeedCubit>().upload();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: _handlePop,
          ),
          title: const Text("피드 업로드"),
          actions: [
            IconButton(
                onPressed: _handleUpload,
                icon: Icon(Icons.upload,
                    size: 30, color: Theme.of(context).colorScheme.primary))
          ],
        ),
        body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          /// Media
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 10),
              Icon(Icons.add_a_photo_outlined,
                  size: 20, color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 10),
              Text('MEDIA',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: Theme.of(context).colorScheme.primary)),
            ],
          ),
          Container(
              margin: const EdgeInsets.only(top: 30),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              child: const SelectFileFragment()),

          const Padding(
              padding: EdgeInsets.symmetric(vertical: 20), child: Divider()),

          Form(
              key: _formKey,
              child: Column(
                children: [
                  /// Caption 텍스트 필드
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 10),
                      Icon(Icons.closed_caption,
                          size: 20,
                          color: Theme.of(context).colorScheme.primary),
                      const SizedBox(width: 10),
                      Text('CAPTION',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.primary)),
                    ],
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                                validator: _handleValidateCaption,
                                maxLength: _maxLengthCaption,
                                minLines: 1,
                                maxLines: 1,
                                onChanged: _handleChangeCaption,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(decorationThickness: 0),
                                decoration: const InputDecoration(
                                    helperText: "캡션을 입력해주세요"))
                          ])),
                  const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Divider()),

                  /// CONTENT 텍스트 필드
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 10),
                      Icon(Icons.abc,
                          size: 20,
                          color: Theme.of(context).colorScheme.primary),
                      const SizedBox(width: 10),
                      Text('CONTENT',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.primary)),
                    ],
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              validator: _handleValidateContent,
                              maxLength: _maxLengthContent,
                              minLines: 3,
                              maxLines: 10,
                              onChanged: _handleChangeContent,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(decorationThickness: 0),
                              decoration: const InputDecoration(
                                  helperText: "본몬을 입력해주세요"),
                            )
                          ])),
                  const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Divider()),

                  /// 해시태그 텍스트 필드
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 10),
                      Icon(Icons.tag,
                          size: 20,
                          color: Theme.of(context).colorScheme.primary),
                      const SizedBox(width: 10),
                      Text('HASHTAG',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.primary)),
                    ],
                  ),
                ],
              )),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: TextFormField(
                  controller: _hashtagTec,
                  maxLength: _maxLengthHashtag,
                  minLines: 1,
                  maxLines: 1,
                  // 해시태그 추가하기 버튼
                  decoration: InputDecoration(
                      helperText: "최대 $_maxCountHashtag개의 해시태그를 입력할 수 있습니다",
                      suffixIcon: _hashtags.length < _maxCountHashtag
                          ? IconButton(
                              onPressed: _handleAddHashtag,
                              icon: const Icon(Icons.add))
                          : null))),

          /// 해시태그 목록
          if (_hashtags.isNotEmpty)
            Padding(
                padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
                child: Wrap(
                    children: List.generate(
                        _hashtags.length,
                        (index) => Container(
                              padding: const EdgeInsets.only(left: 10),
                              margin: const EdgeInsets.only(left: 10, top: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.tag, size: 20),
                                  const SizedBox(width: 5),
                                  Text(
                                    _hashtags[index],
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimaryContainer),
                                  ),
                                  const SizedBox(width: 5),
                                  IconButton(
                                      icon: const Icon(
                                          Icons.delete_outline_outlined,
                                          size: 20),
                                      onPressed: _handleDeleteHashtag(index))
                                ],
                              ),
                            )))),
          const Padding(
              padding: EdgeInsets.only(top: 20, bottom: 50), child: Divider()),
        ])));
  }
}
