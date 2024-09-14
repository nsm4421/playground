part of 'create_reels.page.dart';

class SelectVideoScreen extends StatefulWidget {
  const SelectVideoScreen({super.key});

  @override
  State<SelectVideoScreen> createState() => _SelectVideoScreenState();
}

class _SelectVideoScreenState extends State<SelectVideoScreen> {
  _moveNextStep() {
    if (context.read<CreateReelsBloc>().state.currentAsset != null) {
      context.read<CreateMediaCubit>().switchStep(CreateMediaStep.detail);
      context
          .read<CreateReelsBloc>()
          .add(UpdateStateEvent(step: CreateMediaStep.detail));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("동영상을 선택해주세요"),
        actions: [
          IconButton(
              onPressed: _moveNextStep,
              icon: const Icon(Icons.chevron_right_rounded))
        ],
      ),
      body: BlocBuilder<CreateReelsBloc, CreateReelsState>(
          builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              if (state.currentAsset != null && state.currentAlbum != null)
                DisplayCurrentAlbumWidget(
                    assets: state.assets,
                    currentAsset: state.currentAsset!,
                    currentAlbum: state.currentAlbum!)
            ],
          ),
        );
      }),
    );
  }
}
