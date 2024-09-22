part of 'comment.page.dart';

class ParentCommentScreen extends StatefulWidget {
  const ParentCommentScreen({super.key});

  @override
  State<ParentCommentScreen> createState() => _ParentCommentScreenState();
}

class _ParentCommentScreenState extends State<ParentCommentScreen> {
  late TextEditingController _tec;
  late CustomTimeFormat _timeFormatter;

  @override
  void initState() {
    super.initState();
    _timeFormatter = CustomTimeFormat();
    _tec = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _tec.dispose();
  }

  _submitComment() async {
    try {
      final text = _tec.text.trim();
      final parentComment = context.read<FeedCommentBloc>().state.parentComment;
      if (text.isEmpty) {
        return;
      } else if (parentComment == null) {
        // 부모댓글을 등록한 경우
        context.read<FeedCommentBloc>().add(WriteParentFeedCommentEvent(text));
        _tec.clear();
      } else {
        // 자식댓글을 등록한 경우
        context.read<FeedCommentBloc>().add(WriteChildFeedCommentEvent(
            parentId: parentComment!.id!, content: text));
        _tec.clear();
      }
    } catch (error) {
      log(error.toString());
    }
  }

  _unSelectParentComment() {
    log('un select parent comment button clicked');
    context.read<FeedCommentBloc>().add(UnSelectParentCommentEvent());
  }

  _pop() {
    if (context.mounted) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedCommentBloc, FeedCommentState>(
        builder: (context, state) {
      return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            elevation: 0,
            leading: Icon(Icons.comment_rounded,
                size: CustomTextSize.xl,
                color: Theme.of(context).colorScheme.primary),
            title: Text(state.parentComment == null ? '댓글' : '대댓글',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold)),
            actions: [
              state.parentComment == null
                  ? IconButton(onPressed: _pop, icon: const Icon(Icons.clear))
                  : IconButton(
                      onPressed: _unSelectParentComment,
                      icon: const Icon(Icons.arrow_back))
            ],
          ),
          body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // 댓글목록
            Expanded(
                child: state.parentComment == null
                    ? ParentCommentListFragment(
                        comments: state.comments, timeFormatter: _timeFormatter)
                    : ChildCommentListFragment(
                        parentComment: state.parentComment!,
                        timeFormatter: _timeFormatter)),
            // 텍스트 입력창
            Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: TextField(
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        suffixIcon: (state.status == Status.initial ||
                                state.status == Status.success)
                            ? IconButton(
                                icon: const Icon(Icons.send),
                                onPressed: _submitComment)
                            : Transform.scale(
                                scale: 0.5,
                                child: const CircularProgressIndicator())),
                    controller: _tec))
          ]));
    });
  }
}
