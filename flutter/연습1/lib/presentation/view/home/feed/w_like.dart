part of 'index.dart';

class LikeButtonWidget extends StatelessWidget {
  const LikeButtonWidget(this._feed, {super.key});

  final FeedEntity _feed;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<BlocModule>().feedEmotion(_feed)
        ..initState(emotion: _feed.isLike ? Emotions.like : Emotions.none),
      child: BlocListener<EmotionCubit<FeedEntity>, EmotionState<FeedEntity>>(
        listener: (context, state) async {
          if (state.status == Status.error) {
            log('like request on feed fails|id:${_feed.id}|message:${state.message}');
            await Future.delayed(
              200.ms,
              () {
                context
                    .read<EmotionCubit<FeedEntity>>()
                    .initState(status: Status.initial);
              },
            );
          }
        },
        child: BlocBuilder<EmotionCubit<FeedEntity>, EmotionState<FeedEntity>>(
          builder: (context, state) {
            final tappable = state.status == Status.initial ||
                state.status == Status.success;
            final isLike = state.emotion == Emotions.like;
            return IconButton(
              onPressed: () async {
                if (!tappable) {
                  return;
                } else if (isLike) {
                  log('cancel like request');
                  await context
                      .read<EmotionCubit<FeedEntity>>()
                      .handleCancelLike(_feed.id!);
                } else {
                  log(' like request');
                  await context
                      .read<EmotionCubit<FeedEntity>>()
                      .handleSendLike(_feed.id!);
                }
              },
              icon: Icon(
                isLike ? Icons.favorite : Icons.favorite_border,
                color: context.colorScheme.primary,
              ),
            );
          },
        ),
      ),
    );
  }
}
