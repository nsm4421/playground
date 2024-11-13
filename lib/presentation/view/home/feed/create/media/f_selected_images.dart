part of '../index.dart';

class SelectedImagesFragment extends StatelessWidget
    implements PreferredSizeWidget {
  const SelectedImagesFragment({super.key});

  static const double _height = 150;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateFeedBloc, CreateFeedState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 선택한 이미지 목록
            AnimatedContainer(
              width: state.images.isEmpty ? 0 : context.width,
              height: state.images.isEmpty ? 0 : _height,
              duration: 200.ms,
              child: state.images.isEmpty
                  ? const SizedBox()
                  : SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(
                              state.images.length,
                              (index) {
                                final item = state.images[index];
                                final isSelected = item == state.currentAsset;
                                return GestureDetector(
                                  onTap: () {
                                    context
                                        .read<CreateFeedBloc>()
                                        .add(OnTapImageEvent(item));
                                  },
                                  child: CircleAvatar(
                                    radius: _height / 2,
                                    backgroundColor:
                                        context.colorScheme.primary,
                                    child: AnimatedPadding(
                                      duration: 200.ms,
                                      padding:
                                          EdgeInsets.all(isSelected ? 5 : 0),
                                      child: CircleAvatar(
                                        radius: _height / 2,
                                        backgroundImage:
                                            AssetEntityImageProvider(item),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
            ),
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(_height + 20);
}
