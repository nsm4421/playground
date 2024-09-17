part of 'create_feed.page.dart';

class SelectImageScreen extends StatefulWidget {
  const SelectImageScreen({super.key});

  @override
  State<SelectImageScreen> createState() => _SelectImageScreenState();
}

class _SelectImageScreenState extends State<SelectImageScreen> {
  @override
  initState() {
    super.initState();
    context.read<CreateFeedBloc>().add(FetchAlbumsEvent());
  }

  _moveNextStep() {
    if (context.read<CreateFeedBloc>().state.currentAsset != null) {
      context
          .read<CreateFeedBloc>()
          .add(UpdateStateEvent(step: CreateMediaStep.detail));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("사진을 선택해주세요"),
            actions: [
              IconButton(
                  tooltip: 'NEXT',
                  onPressed: _moveNextStep,
                  icon: Icon(
                    Icons.chevron_right,
                    size: CustomTextSize.xxl,
                  ))
            ],
            elevation: 0),
        body: BlocBuilder<CreateFeedBloc, CreateFeedState>(
            builder: (context, state) {
          return SingleChildScrollView(
              child: Column(children: [
            Container(
                decoration: BoxDecoration(color: Colors.blueGrey[200]),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                child: (state.media == null)
                    ? const Center(child: CircularProgressIndicator())
                    : Image.file(
                        state.media!,
                        fit: BoxFit.fitHeight,
                      )),
            if (state.currentAlbum != null && state.currentAsset != null)
              DisplayCurrentAlbumWidget(
                  assets: state.assets,
                  currentAsset: state.currentAsset!,
                  currentAlbum: state.currentAlbum!)
          ]));
        }));
  }
}
