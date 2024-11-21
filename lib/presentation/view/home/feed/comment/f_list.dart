part of 'index.dart';

class FeedCommentListFragment extends StatelessWidget {
  const FeedCommentListFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DisplayCommentBloc<FeedEntity>,
        CustomDisplayState<CommentEntity>>(
      builder: (context, state) {
        return LoadingOverLayWidget(
          loadingWidget: const Center(child: CircularProgressIndicator()),
          isLoading: state.status == Status.loading,
          childWidget: ListView.separated(
            shrinkWrap: true,
            itemCount: state.data.length,
            itemBuilder: (context, index) {
              final item = state.data[index];
              return Padding(
                padding: const EdgeInsets.all(8),
                child: FeedCommentItemWidget(item),
              );
            },
            separatorBuilder: (_, __) {
              return const Divider(indent: 8, endIndent: 8);
            },
          ),
        );
      },
    );
  }
}
