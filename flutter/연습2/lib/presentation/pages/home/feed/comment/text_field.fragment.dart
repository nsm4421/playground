part of '../../../export.pages.dart';

class CommentTextFieldFragment extends StatefulWidget {
  const CommentTextFieldFragment({super.key});

  @override
  State<CommentTextFieldFragment> createState() =>
      _CommentTextFieldFragmentState();
}

class _CommentTextFieldFragmentState extends State<CommentTextFieldFragment> {
  late TextEditingController _textEditingController;
  bool _enabled = true; // 댓글입력창 편집가능 여부

  static const int _maxLength = 1000;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  _handleSubmit() async {
    // 댓글내용 및 작성가능 여부 검사
    final content = _textEditingController.text.trim();
    if (!_enabled || content.isEmpty) return;
    setState(() {
      _enabled = false;
    });

    // 댓글 상태 업데이트
    context.read<CreateFeedCommentCubit>().updateContent(content);

    // 댓글 업로드
    await context.read<CreateFeedCommentCubit>().submit().then((saved) {
      if (saved == null) return;
      // 댓글 업로드 성공 시 전시된 댓글목록에 추가
      context.read<DisplayFeedCommentBloc>().add(InsertDisplayDataEvent(
          [saved.copyWith(author: context.read<AuthBloc>().state.user!)]));
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textEditingController,
      enabled: _enabled,
      minLines: 1,
      maxLines: 3,
      maxLength: _maxLength,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        counterText: '',
        hintText: 'write comment with maximum $_maxLength characters',
        suffixIcon: BlocListener<CreateFeedCommentCubit, EditFeedCommentState>(
          listener: (context, state) {
            if (state.status == Status.success) {
              // 댓글작성 후 1초동안 로딩상태 해제
              Timer(1.sec, () {
                _textEditingController.clear();
                setState(() {
                  _enabled = true;
                });
              });
            }
          },
          child: BlocBuilder<CreateFeedCommentCubit, EditFeedCommentState>(
              builder: (context, state) => (state.status == Status.initial ||
                      state.status == Status.success)
                  ? IconButton(
                      onPressed: _handleSubmit,
                      icon: const Icon(Icons.send),
                    )
                  : Transform.scale(
                      scale: 0.5, child: const CircularProgressIndicator())),
        ),
      ),
    );
  }
}
