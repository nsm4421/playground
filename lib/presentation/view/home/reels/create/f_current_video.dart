part of 'index.dart';

class CurrentVideoFragment extends StatefulWidget {
  const CurrentVideoFragment({super.key});

  @override
  State<CurrentVideoFragment> createState() => _CurrentVideoFragmentState();
}

class _CurrentVideoFragmentState extends State<CurrentVideoFragment> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _handleInitController();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  _handleInitController() async {
    final file = await context.read<CreateReelsBloc>().state.video?.file;
    if (file != null) {
      _controller = VideoPlayerController.file(file)
        ..initialize().then(
          (_) {
            setState(() {});
            _controller?.play();
          },
        )
        ..setLooping(true);
    }
  }

  _handleTap() {
    if (_controller?.value == null || _controller!.value.isInitialized) {
      return;
    } else if (_controller!.value.isPlaying) {
      _controller?.pause();
    } else {
      _controller?.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateReelsBloc, CreateReelsState>(
      listenWhen: (prev, curr) =>
          (curr.video != null) && (prev.video != curr.video),
      listener: (context, state) async {
        _handleInitController();
      },
      child: SizedBox(
        height: context.width,
        child: Stack(
          children: [
            _controller?.value == null
                ? const Center(child: CircularProgressIndicator())
                : GestureDetector(
                    onTap: _handleTap,
                    child: Container(
                      decoration:
                          BoxDecoration(color: context.colorScheme.shadow),
                      alignment: Alignment.center,
                      child: AspectRatio(
                        aspectRatio: _controller!.value.aspectRatio,
                        child: VideoPlayer(_controller!),
                      ),
                    ),
                  ),
            Positioned(
              top: 15,
              left: 15,
              child: ShadowedIconButton(
                onTap: () {
                  context.pop();
                },
                iconData: Icons.arrow_back,
                iconColor: CustomPalette.white,
                iconSize: 30,
              ),
            )
          ],
        ),
      ),
    );
  }
}
