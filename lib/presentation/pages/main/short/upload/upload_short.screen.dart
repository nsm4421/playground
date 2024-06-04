part of 'upload_short.page.dart';

class UploadShortScreen extends StatefulWidget {
  const UploadShortScreen({super.key});

  @override
  State<UploadShortScreen> createState() =>
      _UploadShortScreenState();
}

class _UploadShortScreenState extends State<UploadShortScreen> {
  static const _maxLengthTitle = 30;
  static const _maxLengthContent = 300;

  late TextEditingController _titleTec;
  late TextEditingController _contentTec;
  File? _video;

  @override
  void initState() {
    super.initState();
    _titleTec = TextEditingController();
    _contentTec = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _titleTec.dispose();
    _contentTec.dispose();
  }

  _setVideo(File? video) {
    _video = video;
  }

  _handleUpload() {
    // validate
    final title = _titleTec.text.trim();
    final content = _contentTec.text.trim();
    if (title.isEmpty || content.isEmpty || _video == null) {
      return;
    }
    // upload
    context
        .read<UploadShortCubit>()
        .uploadShort(title: title, content: content, video: _video!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("UPLOAD SHORT"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: VideoPreviewForUploadWidget(
                setVideo: _setVideo,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  // 영상 제목
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 30, left: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("TITLE",
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary)),
                        TextFormField(
                            controller: _titleTec,
                            maxLength: _maxLengthTitle,
                            maxLines: 1,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder())),
                      ],
                    ),
                  ),

                  // 영상 설명
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 30, left: 10, right: 10),
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
                            controller: _contentTec,
                            maxLength: _maxLengthContent,
                            minLines: 3,
                            maxLines: 10,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder())),
                      ],
                    ),
                  )
                ],
              ),
            ),

            // 제출버튼
            Padding(
              padding: const EdgeInsets.only(
                  top: 30, bottom: 20, left: 10, right: 10),
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Theme.of(context).colorScheme.primaryContainer),
                    foregroundColor: MaterialStateProperty.all<Color>(
                        Theme.of(context).colorScheme.primary),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                  onPressed: _handleUpload,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "UPLOAD",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontWeight: FontWeight.w800),
                      ),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
