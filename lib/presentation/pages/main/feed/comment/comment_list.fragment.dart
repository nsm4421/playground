part of 'feed_comment.page.dart';

class CommentListFragment extends StatefulWidget {
  const CommentListFragment({super.key});

  @override
  State<CommentListFragment> createState() => _CommentListFragmentState();
}

class _CommentListFragmentState extends State<CommentListFragment> {
  List<FeedCommentEntity> _comments = [];
  late RealtimeChannel _channel;

  @override
  void initState() {
    super.initState();
    // DB에 insert가 발생한 경우
    _channel = context.read<DisplayFeedCommentBloc>().createChannel(
        changeEvent: PostgresChangeEvent.insert, callback: _callback);
    _channel.subscribe();
  }

  @override
  dispose() {
    super.dispose();
    _channel.unsubscribe();
  }

  _callback(FeedCommentEntity? oldRecord, FeedCommentEntity? newRecord) {
    if (newRecord != null) {
      setState(() {
        _comments = [newRecord, ..._comments];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DisplayFeedCommentBloc, DisplayFeedCommentState>(
      listener: (context, state) {
        if (state is FeedCommentFetchedState) {
          setState(() {
            _comments.addAll(state.fetched);
          });
        }
      },
      child: BlocBuilder<DisplayFeedCommentBloc, DisplayFeedCommentState>(
        builder: (context, state) {
          if (state is InitialDisplayFeedCommentState ||
              state is DisplayFeedCommentSuccessState) {
            return ListView.separated(
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final comment = _comments[index];
                  return ListTile(
                    leading: AvatarWidget(comment.author!.profileUrl!),
                    title: Text(comment.content ?? ''),
                    // TODO : 시간 포맷팅
                    subtitle: Text(comment.createdAt?.toString() ?? ''),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Divider());
                },
                itemCount: _comments.length);
          } else if (state is DisplayFeedCommentLoadingState) {
            return const LoadingFragment();
          } else {
            return const ErrorFragment();
          }
        },
      ),
    );
  }
}
