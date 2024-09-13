part of 'create_feed.page.dart';

class DisplayCurrentAlbumWidget extends StatefulWidget {
  const DisplayCurrentAlbumWidget(
      {super.key,
      required this.assets,
      required this.currentAsset,
      required this.currentAlbum});

  final List<AssetEntity> assets;
  final AssetEntity currentAsset;
  final AssetPathEntity currentAlbum;

  @override
  State<DisplayCurrentAlbumWidget> createState() =>
      _DisplayCurrentAlbumWidgetState();
}

class _DisplayCurrentAlbumWidgetState extends State<DisplayCurrentAlbumWidget> {
  _showDirectoryModal() async {
    await showModalBottomSheet<AssetPathEntity?>(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(CustomSpacing.md),
          topRight: Radius.circular(CustomSpacing.md),
        )),
        context: context,
        builder: (_) {
          return SelectDirectoryFragment(
              context.read<CreateFeedBloc>().state.albums);
        }).then((album) {
      if (album == null) {
        return;
      }
      context.read<CreateFeedBloc>().add(SelectAlbumEvent(album: album));
    });
  }

  _selectAsset(AssetEntity asset) => () {
        context.read<CreateFeedBloc>().add(SelectAssetEvent(asset));
      };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 헤더
        Padding(
            padding: EdgeInsets.all(CustomSpacing.tiny),
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              ElevatedButton(
                  onPressed: _showDirectoryModal,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.currentAlbum.name,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Theme.of(context).colorScheme.onSecondary),
                      ),
                      CustomWidth.tiny,
                      const Icon(Icons.arrow_drop_down),
                    ],
                  ))
            ])),

        // 이미지 목록
        GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 1, // 가로 방향 margin
                crossAxisSpacing: 1, // 세로 방향 margin
                crossAxisCount: 4, // 가로로 배치할 개수
                childAspectRatio: 1 // 정사각형 모양
                ),
            itemCount: widget.assets.length,
            itemBuilder: (context, index) {
              final asset = widget.assets[index];
              return GestureDetector(
                  onTap: _selectAsset(asset),
                  child: Opacity(
                      opacity: widget.currentAsset == asset ? 0.3 : 1,
                      child: ImagePreviewWidget(asset)));
            }),

        // 더 가져오기 버튼
        Padding(
          padding: EdgeInsets.symmetric(vertical: CustomSpacing.lg),
          child: const FetchMoreButton(),
        )
      ],
    );
    ;
  }
}

class FetchMoreButton extends StatelessWidget {
  const FetchMoreButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateFeedBloc, CreateFeedState>(
        builder: (context, state) {
      if (state.isEnd) {
        return const SizedBox();
      }
      switch (state.status) {
        case Status.initial:
        case Status.success:
          return IconButton(
              tooltip: '더 가져오기',
              onPressed: () {
                context.read<CreateFeedBloc>().add(FetchMoreAssetsEvent());
              },
              icon: Icon(
                Icons.rotate_left,
                size: CustomTextSize.xxl,
              ));
        case Status.loading:
        case Status.error:
          return const Center(child: CircularProgressIndicator());
      }
    });
  }
}
