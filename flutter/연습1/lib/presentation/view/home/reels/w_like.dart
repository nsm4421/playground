part of 'index.dart';

class LikeButtonWidget extends StatelessWidget {
  const LikeButtonWidget(this._reels, {super.key, this.iconSize = 35});

  final double iconSize;
  final ReelsEntity _reels;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<BlocModule>().reelsEmotion(_reels)
        ..initState(emotion: _reels.isLike ? Emotions.like : Emotions.none),
      child: BlocListener<EmotionCubit<ReelsEntity>, EmotionState<ReelsEntity>>(
        listener: (context, state) async {
          if (state.status == Status.error) {
            await Future.delayed(
              200.ms,
              () {
                context
                    .read<EmotionCubit<ReelsEntity>>()
                    .initState(status: Status.initial);
              },
            );
          }
        },
        child:
            BlocBuilder<EmotionCubit<ReelsEntity>, EmotionState<ReelsEntity>>(
          builder: (context, state) {
            final tappable = state.status == Status.initial ||
                state.status == Status.success;
            final isLike = state.emotion == Emotions.like;
            return ShadowedIconButton(
              onTap: () async {
                if (!tappable) {
                  return;
                } else if (isLike) {
                  log('cancel like request');
                  await context
                      .read<EmotionCubit<ReelsEntity>>()
                      .handleCancelLike(_reels.id!);
                } else {
                  log('like request');
                  await context
                      .read<EmotionCubit<ReelsEntity>>()
                      .handleSendLike(_reels.id!);
                }
              },
              iconData: isLike ? Icons.favorite : Icons.favorite_border,
              iconSize: iconSize,
              iconColor:
                  isLike ? context.colorScheme.primary : CustomPalette.white,
            );
          },
        ),
      ),
    );
  }
}
