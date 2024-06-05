part of 'upload_feed.page.dart';

class UploadFeedScreen extends StatefulWidget {
  const UploadFeedScreen({super.key});

  @override
  State<UploadFeedScreen> createState() => _UploadFeedScreenState();
}

class _UploadFeedScreenState extends State<UploadFeedScreen> {
  static const _maxLengthContent = 500;
  static const _maxLengthHashtag = 30;
  static const _maxCountHashtag = 3;

  late TextEditingController _textEditingController;
  late TextEditingController _hashtagEditingController;

  File? _video;
  List<File> _images = [];
  List<String> _hashtags = [];

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _hashtagEditingController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
    _hashtagEditingController.dispose();
  }

  _setVideo(File? video) {
    _video = video;
  }

  _handleAddHashtag() {
    final hashtag = _hashtagEditingController.text.trim();
    // TODO : Validation
    if (_hashtags.length >= _maxCountHashtag) {
      return;
    } else if (_hashtags.contains(hashtag)) {
      return;
    } else {
      setState(() {
        _hashtags.add(hashtag);
      });
      _hashtagEditingController.clear();
    }
  }

  _handleDeleteHashtag(int index) => () => setState(() {
        _hashtags.removeAt(index);
      });

  _handleUpload() {
    // validate
    final text = _textEditingController.text.trim();
    // upload
    context.read<FeedBloc>().add(UploadFeedEvent(
        text: text, hashtags: _hashtags, images: _images, video: _video));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("UPLOAD FEED"),
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          // 영상 선택
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: VideoPreviewForUploadWidget(
              setVideo: _setVideo,
              width: MediaQuery.of(context).size.width,
            ),
          ),

          // 본문
          Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(children: [
                // 본문
                Padding(
                  padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("CONTENT",
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.primary)),
                      TextFormField(
                          controller: _textEditingController,
                          maxLength: _maxLengthContent,
                          minLines: 3,
                          maxLines: 10,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder())),
                    ],
                  ),
                ),

                // 해시태그
                Padding(
                    padding:
                        const EdgeInsets.only(top: 30, left: 10, right: 10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("HASHTAG",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary)),
                          TextFormField(
                              controller: _hashtagEditingController,
                              maxLength: _maxLengthHashtag,
                              minLines: 1,
                              maxLines: 1,
                              decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  suffixIcon: IconButton(
                                      onPressed: _handleAddHashtag,
                                      icon: const Icon(Icons.add)))),
                        ])),

                if (_hashtags.isNotEmpty)
                Padding(
                    padding:
                        const EdgeInsets.only(top: 30, left: 10, right: 10),
                    child: Wrap(
                        children: List.generate(
                            _hashtags.length,
                            (index) => Chip(
                                    label: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(_hashtags[index]),
                                    const SizedBox(width: 5),
                                    IconButton(
                                        icon: const Icon(Icons.clear),
                                        onPressed: _handleDeleteHashtag(index))
                                  ],
                                )))))
              ])),

          // 제출버튼
          Padding(
              padding: const EdgeInsets.only(
                  top: 30, bottom: 20, left: 10, right: 10),
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                          Theme.of(context).colorScheme.primaryContainer),
                      foregroundColor: WidgetStateProperty.all<Color>(
                          Theme.of(context).colorScheme.primary),
                      padding: WidgetStateProperty.all<EdgeInsets>(
                          const EdgeInsets.symmetric(vertical: 8))),
                  onPressed: _handleUpload,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("UPLOAD",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(fontWeight: FontWeight.w800))
                      ])))
        ])));
  }
}
