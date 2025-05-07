part of '../../../export.pages.dart';

class SelectImageFragment extends StatefulWidget {
  const SelectImageFragment({super.key});

  @override
  State<SelectImageFragment> createState() => _SelectImageFragmentState();
}

class _SelectImageFragmentState extends State<SelectImageFragment> {
  late PageController _controller;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  dispose() {
    super.dispose();
    _controller.dispose();
  }

  _handlePageChange(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  _handleOnTap(AssetEntity asset) => () {
        final isSelected = context
            .read<SelectMediaCubit>()
            .state
            .selected
            .map((item) => item.id)
            .contains(asset.id);
        setState(() {
          _currentIndex = 0;
        });
        if (isSelected) {
          context.read<SelectMediaCubit>().unSelectAsset(asset);
        } else {
          context.read<SelectMediaCubit>().selectAsset(asset);
        }
      };

  _handleUnSelect() {
    context.read<SelectMediaCubit>().unSelectAsset(
        context.read<SelectMediaCubit>().state.selected[_currentIndex]);
    setState(() {
      _currentIndex = 0;
    });
  }

  _handleFetchMore() async {
    await context.read<SelectMediaCubit>().fetchMoreAssets();
  }

  _handleSelectAlbum(List<AssetPathEntity> albums) => () async {
        await showModalBottomSheet(
          context: context,
          showDragHandle: true,
          builder: (ctx) {
            return ListView.separated(
              shrinkWrap: true,
              itemCount: albums.length,
              itemBuilder: (_, index) {
                final album = albums[index];
                return ListTile(
                  onTap: () async {
                    if (index !=
                        context.read<SelectMediaCubit>().state.albumIndex) {
                      ctx.pop();
                      await context.read<SelectMediaCubit>().switchAlbum(index);
                    }
                  },
                  title: Text(album.name),
                );
              },
              separatorBuilder: (_, __) => const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                child: Divider(),
              ),
            );
          },
        );
      };

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectMediaCubit, SelectMediaState>(
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      decoration:
                          BoxDecoration(color: Colors.black87.withOpacity(0.8)),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width,
                      child: PageView.builder(
                          controller: _controller,
                          onPageChanged: _handlePageChange,
                          itemCount: state.selected.length,
                          itemBuilder: (context, index) {
                            return AssetEntityImage(
                                width: MediaQuery.of(context).size.width,
                                state.selected[index],
                                fit: BoxFit.cover);
                          }),
                    ),
                    if (state.selected.length > 1)
                      Positioned(
                        top: 12,
                        right: 8,
                        child: GestureDetector(
                          onTap: _handleUnSelect,
                          child: Container(
                            decoration: BoxDecoration(
                                color: context.colorScheme.tertiaryContainer,
                                shape: BoxShape.circle),
                            child: Icon(
                              Icons.clear,
                              color: context.colorScheme.onTertiaryContainer,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, bottom: 12),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: _handleSelectAlbum(state.albums),
                        child: Row(
                          children: [
                            Transform.rotate(
                                angle: -90 * (3.14159265359 / 180),
                                child: const Icon(Icons.chevron_left)),
                            Text(
                              state.currentAlbum.name,
                              style: context.textTheme.labelLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Stack(
                  children: [
                    GridView.builder(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 4,
                      ),
                      itemCount: state.assets.length,
                      itemBuilder: (context, index) {
                        final AssetEntity asset = state.assets[index];
                        final isSelected = state.selected
                            .map((item) => item.id)
                            .contains(asset.id);
                        return GestureDetector(
                          onTap: state.status != Status.loading
                              ? _handleOnTap(asset)
                              : null,
                          child: Stack(
                            children: [
                              Opacity(
                                opacity: isSelected ? 0.2 : 1,
                                child: SizedBox(
                                  width: double.infinity,
                                  child: AssetEntityImage(asset,
                                      fit: BoxFit.cover),
                                ),
                              ),
                              if (isSelected)
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        color: Colors.black,
                                        shape: BoxShape.circle),
                                    child: const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                            ],
                          ),
                        );
                      },
                    ),
                    if (!state.isEnd && state.status != Status.loading)
                      Positioned(
                        right: 12,
                        bottom: 12,
                        child: Center(
                          child: ElevatedButton(
                            onPressed: _handleFetchMore,
                            child: const Text("Fetch More"),
                          ),
                        ),
                      )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
