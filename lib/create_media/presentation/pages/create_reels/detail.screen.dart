part of 'create_reels.page.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late VideoPlayerController _videoController;
  late TextEditingController _tec;
  late Future<void> _initVideoPlayerFuture;

  @override
  initState() {
    super.initState();
    _videoController = VideoPlayerController.file(
        context.read<CreateReelsBloc>().state.media!);
    _tec = TextEditingController();
    _initVideoPlayerFuture = _videoController.initialize();
    _videoController.setLooping(true);
    _videoController.setVolume(0);
    _videoController.play();
  }

  @override
  void dispose() {
    super.dispose();
    _videoController.dispose();
    _tec.dispose();
  }

  _moveBack() {
    context.read<CreateMediaCubit>().switchStep(CreateMediaStep.selectMedia);
    context
        .read<CreateReelsBloc>()
        .add(UpdateStateEvent(step: CreateMediaStep.selectMedia));
  }

  _handlePlayVideo() {
    if (!_videoController.value.isInitialized) return;
    _videoController.value.isPlaying
        ? _videoController.pause()
        : _videoController.play();
  }

  _showEditCaption() async {
    await showModalBottomSheet(
        context: context,
        showDragHandle: false,
        builder: (context) {
          return EditCaptionFragment(_tec);
        });
  }

  _uploadReels() {
    if (_tec.text.trim().isEmpty) {
      getIt<CustomSnakbar>().error(title: '캡션을 입력해주세요');
      return;
    }
    context.read<CreateReelsBloc>().add(UploadEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            leading: IconButton(
                onPressed: _moveBack, icon: const Icon(Icons.chevron_left)),
            title: const Text('릴스를 작성해주세요')),
        body: SingleChildScrollView(
            child: Column(children: [
          GestureDetector(
              onTap: _handlePlayVideo,
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width * 1.5,
                  child: FutureBuilder(
                      future: _initVideoPlayerFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return AspectRatio(
                            aspectRatio: _videoController.value.aspectRatio,
                            child: VideoPlayer(_videoController),
                          );
                        }
                        return Center(
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width / 4,
                              height: MediaQuery.of(context).size.width / 4,
                              child: const CircularProgressIndicator()),
                        );
                      }))),

          // 캡션
          Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: CustomSpacing.sm, vertical: CustomSpacing.lg),
              child: TextField(
                  controller: _tec,
                  onTap: _showEditCaption,
                  minLines: 3,
                  maxLines: 5,
                  decoration: const InputDecoration(
                      labelText: 'Caption',
                      hintText: '캡션을 입력해주세요',
                      border: OutlineInputBorder()),
                  readOnly: true))
        ])),
        floatingActionButton: FloatingActionButton.small(
          onPressed: _uploadReels,
          child: Icon(Icons.check,
              color: Theme.of(context).colorScheme.primary,
              size: CustomTextSize.xl),
        ));
  }
}
