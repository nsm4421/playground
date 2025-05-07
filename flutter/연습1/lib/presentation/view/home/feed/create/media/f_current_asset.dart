part of '../index.dart';

class CurrentAssetFragment extends StatelessWidget {
  const CurrentAssetFragment({super.key});

  static const double _iconSize = 30;

  @override
  Widget build(BuildContext context) {
    final maxImageNum = context.read<CreateFeedBloc>().maxImageNum;
    return BlocBuilder<CreateFeedBloc, CreateFeedState>(
      builder: (context, state) {
        final isSelected = state.images.contains(state.currentAsset);
        return state.currentAsset == null
            ? const CircularProgressIndicator()
            : Stack(
                children: [
                  SizedBox(
                    width: context.width,
                    height: context.width,
                    child: AssetEntityImage(state.currentAsset!,
                        fit: BoxFit.cover),
                  ),
                  if (isSelected)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: CustomPalette.darkGrey),
                        child: Text(
                          '${state.index + 1}/$maxImageNum',
                          style: context.textTheme.labelLarge
                              ?.copyWith(color: CustomPalette.white),
                        ),
                      ),
                    ),
                  if (!isSelected && state.images.length < maxImageNum)
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: RoundedIconWidget(
                        iconData: Icons.add,
                        size: _iconSize,
                        onTap: () {
                          context
                              .read<CreateFeedBloc>()
                              .add(SelectImageEvent(state.currentAsset!));
                        },
                      ),
                    ),
                  if (isSelected)
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 8),
                          child: RoundedIconWidget(
                            iconData: Icons.clear,
                            size: 30,
                            onTap: () {
                              context
                                  .read<CreateFeedBloc>()
                                  .add(UnSelectImageEvent());
                            },
                          ),
                        ),
                      ),
                    )
                ],
              );
      },
    );
  }
}
