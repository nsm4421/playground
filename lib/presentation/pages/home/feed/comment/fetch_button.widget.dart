part of '../../../export.pages.dart';

class FetchMoreCommentButton extends StatelessWidget{
  const FetchMoreCommentButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DisplayFeedCommentBloc, DisplayState<CommentEntity>>(
        builder: (context, state) {
      if (state.isEnd || !state.isMounted) return const SizedBox.shrink();
      return ElevatedButton(onPressed: () {
      LoggerUtil().logger.d(context.read<DisplayFeedCommentBloc>().state.currentPage);
      LoggerUtil().logger.d(context.read<DisplayFeedCommentBloc>().state.totalPages);
      LoggerUtil().logger.d(context.read<DisplayFeedCommentBloc>().state.isEnd);
        context.read<DisplayFeedCommentBloc>().add(FetchEvent());
      }, child: const Text("Fetch More"));
    });
  }
}
