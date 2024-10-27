part of 'page.dart';

class CommentListFragment extends StatefulWidget {
  const CommentListFragment({super.key});

  @override
  State<CommentListFragment> createState() => _CommentListFragmentState();
}

class _CommentListFragmentState extends State<CommentListFragment> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_handleScroll);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController
      ..removeListener(_handleScroll)
      ..dispose();
  }

  void _handleScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 30) {
      Timer(const Duration(seconds: 1), () {
        context
            .read<DisplayCommentBloc<DiaryEntity>>()
            .add(FetchEvent<CommentEntity>());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DisplayCommentBloc<DiaryEntity>,
        CustomDisplayState<CommentEntity>>(builder: (context, state) {
      return LoadingOverLayScreen(
          isLoading: state.isFetching,
          loadingWidget: const Center(child: CircularProgressIndicator()),
          childWidget: RefreshIndicator(
              onRefresh: () async {
                context
                    .read<DisplayCommentBloc<DiaryEntity>>()
                    .add(FetchEvent<CommentEntity>(refresh: true));
              },
              child: ListView.separated(
                  controller: _scrollController,
                  shrinkWrap: true,
                  itemCount: state.data.length,
                  itemBuilder: (context, index) {
                    final item = state.data[index];
                    return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircularAvatarWidget(item.author!.avatarUrl),
                          const SizedBox(width: 16),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(children: [
                                  Text(item.author!.username,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                              fontWeight: FontWeight.w500,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .tertiary)),
                                  const SizedBox(width: 16),
                                  Text(
                                      customUtil.timeAgoInKr(
                                          item.createdAt!.toIso8601String()),
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge
                                          ?.copyWith(
                                              fontWeight: FontWeight.w400,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .tertiary))
                                ]),
                                const SizedBox(height: 8),
                                ExpandableTextWidget(item.content ?? '',
                                    minLine: 1,
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 1.5,
                                            wordSpacing: 3))
                              ])
                        ]);
                  },
                  separatorBuilder: (context, index) {
                    if (state.isEnd) {
                      return const SizedBox();
                    } else if (index == state.data.length - 1) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Divider());
                    }
                  })));
    });
  }
}
