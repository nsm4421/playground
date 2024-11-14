part of 'index.dart';

class CurrentAssetFabWidget extends StatelessWidget {
  const CurrentAssetFabWidget({super.key});

  static const double _size = 30;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RoundedIconWidget(
              iconData: Icons.edit,
              size: _size,
              onTap: () async {
                await showModalBottomSheet<String?>(
                  context: context,
                  isScrollControlled: true,
                  builder: (_) {
                    return EditCaptionFragment(
                      currentImage:
                          context.read<CreateFeedBloc>().state.currentAsset!,
                      initText: context
                          .read<CreateFeedBloc>()
                          .state
                          .captions[context.read<CreateFeedBloc>().state.index],
                    );
                  },
                ).then((res) {
                  if (res == null) return;
                  context.read<CreateFeedBloc>().add(EditContentEvent(res));
                });
              },
            ),
            (12.0).h,
            RoundedIconWidget(
              iconData: Icons.clear,
              size: _size,
              onTap: () {
                context.read<CreateFeedBloc>().add(UnSelectImageEvent());
              },
            ),
          ],
        ),
      ),
    );
  }
}

class NavigateFabWidget extends StatelessWidget {
  const NavigateFabWidget({super.key, required this.onTap});

  static const double _size = 30;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: RoundedIconWidget(
        onTap: onTap,
        iconData: Icons.chevron_right,
        size: _size,
        bgColor: context.colorScheme.primary,
        iconColor: context.colorScheme.onPrimary,
      ),
    );
  }
}

class SubmitFabWidget extends StatelessWidget {
  const SubmitFabWidget({super.key});

  static const double _size = 30;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: RoundedIconWidget(
        onTap: () async {
          FocusScope.of(context).unfocus();
          await Future.delayed(200.ms, () {
            context.read<CreateFeedBloc>().add(SubmitEvent());
          });
        },
        iconData: Icons.chevron_right,
        size: _size,
        bgColor: context.colorScheme.primary,
        iconColor: context.colorScheme.onPrimary,
      ),
    );
  }
}
