part of '../../../export.pages.dart';

class FetchMoreCommentButton extends StatelessWidget{
  const FetchMoreCommentButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DisplayFeedCommentBloc, DisplayState<CommentEntity>>(
        builder: (context, state) {
      if (state.isEnd || !state.isMounted) return const SizedBox.shrink();
      return ElevatedButton(onPressed: () {
        context.read<DisplayFeedCommentBloc>().add(FetchEvent());
      }, child: const Text("Fetch More"));
    });
  }
}
