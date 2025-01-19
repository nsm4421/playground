part of '../../export.pages.dart';

class LikeIconWidget extends StatelessWidget {
  const LikeIconWidget(this._feed, {super.key});

  final FeedEntity _feed;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<FeedReactionCubit>(param1: _feed),
      child: BlocBuilder<FeedReactionCubit, ReactionState<FeedEntity>>(
        builder: (context, state) {
          return IconButton(
            onPressed: () async {
              state.like
                  ? await context.read<FeedReactionCubit>().cancelLike()
                  : await context.read<FeedReactionCubit>().like();
            },
            icon: Icon(
              state.like ? Icons.favorite : Icons.favorite_border,
              color: context.colorScheme.secondary,
            ),
          );
        },
      ),
    );
  }
}
