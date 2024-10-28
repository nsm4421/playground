part of 'page.dart';

class DisplayAvatarFragment extends StatefulWidget {
  const DisplayAvatarFragment(this._height, {super.key});

  final double _height;

  @override
  State<DisplayAvatarFragment> createState() => _DisplayAvatarFragmentState();
}

class _DisplayAvatarFragmentState extends State<DisplayAvatarFragment> {
  _handleUnSelect(int index) => () {
        context.read<EditFeedBloc>().add(UnSelectAssetEvent(index));
      };

  _handleTapAsset({required int index, required FeedAsset asset}) => () async {
        await showModalBottomSheet<FeedAsset?>(
            context: context,
            showDragHandle: true,
            useSafeArea: true,
            isScrollControlled: true,
            builder: (context) => EditAssetWidget(asset)).then((res) {
          if (res == null) {
            _handleUnSelect(index);
          } else {
            context
                .read<EditFeedBloc>()
                .add(ChangeAssetEvent(index: index, asset: res));
          }
        });
      };

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditFeedBloc, EditFeedState>(
        builder: (context, state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            const Icon(Icons.add_a_photo_outlined),
            const SizedBox(width: 12),
            Text('Assets',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold))
          ]),
          state.assets.isEmpty
              ? const Text('no asset selected')
              : Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: widget._height,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: state.assets.length,
                          itemBuilder: (context, index) {
                            final asset = state.assets[index];
                            return GestureDetector(
                              onTap:
                                  _handleTapAsset(index: index, asset: asset),
                              child: Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: Stack(children: [
                                    // 이미지 미리보기
                                    CircleAvatar(
                                        radius: widget._height / 2,
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .secondaryContainer,
                                        backgroundImage:
                                            FileImage(asset.image)),
                                    // 취소버튼
                                    Positioned(
                                        top: -widget._height / 6,
                                        right: -widget._height / 6,
                                        child: IconButton(
                                            icon: const Icon(Icons.clear,
                                                size: 20),
                                            onPressed: _handleUnSelect(index)))
                                  ])),
                            );
                          })))
        ],
      );
    });
  }
}
