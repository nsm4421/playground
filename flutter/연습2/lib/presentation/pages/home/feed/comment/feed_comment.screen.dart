part of '../../../export.pages.dart';

class FeedCommentScreen extends StatelessWidget {
  const FeedCommentScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DisplayFeedCommentBloc, DisplayState<CommentEntity>>(
      builder: (context, state) {
        return LoadingOverLayWidget(
          isLoading: state.status == Status.loading,
          loadingWidget: const Center(child: CircularProgressIndicator()),
          child: Scaffold(
            body: GestureDetector(
                onTap: (){
                  FocusScope.of(context).unfocus();
                },
                child: DisplayCommentFragment(state.data)),
            bottomNavigationBar: const CommentTextFieldFragment(),
          ),
        );
      },
    );
  }
}
