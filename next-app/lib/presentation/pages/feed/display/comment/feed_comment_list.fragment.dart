part of "display_feed_comment.page.dart";

class FeedCommentListFragment extends StatefulWidget {
  const FeedCommentListFragment({super.key});

  @override
  State<FeedCommentListFragment> createState() =>
      _FeedCommentListFragmentState();
}

class _FeedCommentListFragmentState extends State<FeedCommentListFragment> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DisplayFeedCommentBloc, DisplayFeedCommentState>(
      builder: (context, state) {
        final data = context.read<DisplayFeedCommentBloc>().state.data;
        return ListView.builder(
          shrinkWrap: true,
          itemCount: data.length,
          itemBuilder: (context, index) => FeedCommentItemWidget(data[index]),
        );
      },
    );
  }
}
