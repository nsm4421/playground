part of '../../../export.pages.dart';

class DisplayCommentFragment extends StatelessWidget {
  const DisplayCommentFragment(this._comments, {super.key});

  final List<CommentEntity> _comments;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      reverse: true,
      itemCount: _comments.length,
      itemBuilder: (context, index) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (index == _comments.length - 1 &&
                !context.read<DisplayFeedCommentBloc>().state.isEnd)
              const FetchMoreCommentButton(),
            CommentItemWidget(_comments[index]),
          ],
        );
      },
      separatorBuilder: (context, index) {
        return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Divider());
      },
    );
  }
}
