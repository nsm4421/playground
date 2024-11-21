part of '../widget.dart';

class CommentListWidget<RefEntity extends BaseEntity> extends StatefulWidget {
  const CommentListWidget({super.key});

  @override
  State<CommentListWidget<RefEntity>> createState() =>
      _CommentListWidgetState<RefEntity>();
}

class _CommentListWidgetState<RefEntity extends BaseEntity>
    extends State<CommentListWidget<RefEntity>> {
  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController()..addListener(_handleScroll);
  }

  @override
  void dispose() {
    super.dispose();
    _controller
      ..removeListener(_handleScroll)
      ..dispose();
  }

  _handleScroll() {
    if (_controller.position.extentAfter < 20 &&
        !context.read<DisplayCommentBloc<RefEntity>>().state.isEnd &&
        context.read<DisplayCommentBloc<RefEntity>>().state.status !=
            Status.loading) {
      log('fetch more comments');
      context
          .read<DisplayCommentBloc<RefEntity>>()
          .add(FetchEvent<CommentEntity>());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DisplayCommentBloc<RefEntity>,
        CustomDisplayState<CommentEntity>>(
      builder: (context, state) {
        return LoadingOverLayWidget(
          loadingWidget: const Center(child: CircularProgressIndicator()),
          isLoading: state.status == Status.loading,
          childWidget: RefreshIndicator(
            onRefresh: () async {
              context
                  .read<DisplayCommentBloc<RefEntity>>()
                  .add(FetchEvent(refresh: true));
            },
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: state.data.length,
              controller: _controller,
              itemBuilder: (context, index) {
                final item = state.data[index];
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: CommentItemWidget(item),
                );
              },
              separatorBuilder: (_, index) {
                return const Divider(indent: 8, endIndent: 8);
              },
            ),
          ),
        );
      },
    );
  }
}

class CommentItemWidget extends StatelessWidget {
  const CommentItemWidget(this.comment, {super.key});

  final CommentEntity comment;

  @override
  Widget build(BuildContext context) {
    final dt = comment.createdAt!.toLocal();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        // TODO : 버튼 누르면 자식 댓글 화면으로
      },
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CachedCircularImageWidget(comment.author.avatarUrl),
                  (12.0).w,
                  Text(comment.author.username,
                      style: context.textTheme.bodySmall),
                  const Spacer(),
                  // TODO : Time formatting
                  Text(
                    '${dt.year}-${dt.month}-${dt.day}',
                    style: context.textTheme.labelSmall,
                  )
                ],
              ),
              (16.0).h,
              Row(
                children: [
                  (12.0).w,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ExpandableTextWidget(comment.content,
                            textStyle: context.textTheme.bodyMedium),
                        if (comment.childCount > 0)
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Text(
                              '${comment.childCount.toString()} Replies',
                              style: context.textTheme.titleSmall?.copyWith(
                                color: CustomPalette.secondary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                  (12.0).w,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
