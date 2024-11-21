part of 'index.dart';

class EditCommentWidget extends StatefulWidget {
  const EditCommentWidget({super.key});

  @override
  State<EditCommentWidget> createState() => _EditCommentWidgetState();
}

class _EditCommentWidgetState extends State<EditCommentWidget> {
  static const int _maxLength = 500;
  static const int _maxLines = 3;

  int _textLength = 0;
  late TextEditingController _controller;
  late FocusNode _focusNode;
  late String _commentId;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode()..addListener(_handleFocus);
    _commentId = context.read<CreateCommentCubit<FeedEntity>>().commentId;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _focusNode
      ..removeListener(_handleFocus)
      ..dispose();
  }

  _handleFocus() {
    if (!_focusNode.hasFocus) {
      context
          .read<CreateCommentCubit<FeedEntity>>()
          .handleContent(_controller.text);
    }
  }

  _handleOnChange(String text) {
    setState(() {
      _textLength = text.length;
    });
  }

  _handleSubmit() async {
    if (_controller.text.isEmpty) return;
    FocusScope.of(context).unfocus();
    await Future.delayed(200.ms, () async {
      await context
          .read<CreateCommentCubit<FeedEntity>>()
          .handleSubmitParentComment();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateCommentCubit<FeedEntity>,
        CreateCommentState<FeedEntity>>(
      listener: (context, state) async {
        if (state.status == Status.success) {
          _controller.clear();
          // TODO : 댓글 추가
          _commentId = context.read<CreateCommentCubit<FeedEntity>>().commentId;
        } else if (state.status == Status.error) {
          getIt<CustomSnackBar>()
              .error(title: 'Error', description: state.message);
          await Future.delayed(200.ms, () {
            context
                .read<CreateCommentCubit<FeedEntity>>()
                .initState(status: Status.initial, message: '');
          });
        }
      },
      child: BlocBuilder<CreateCommentCubit<FeedEntity>,
          CreateCommentState<FeedEntity>>(
        builder: (context, state) {
          return TextField(
            onChanged: _handleOnChange,
            focusNode: _focusNode,
            controller: _controller,
            maxLength: _maxLength,
            minLines: 1,
            maxLines: _maxLines,
            decoration: InputDecoration(
              label: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Content  ',
                      style: context.textTheme.bodyMedium,
                    ),
                    TextSpan(
                      text: '($_textLength/$_maxLength)',
                      style: context.textTheme.labelLarge,
                    )
                  ],
                ),
              ),
              counterText: '',
              border: const OutlineInputBorder(),
              suffixIcon: switch (state.status) {
                Status.error => const Icon(Icons.error_outline),
                Status.loading => Transform.scale(
                    scale: 0.5,
                    child: const CircularProgressIndicator(),
                  ),
                (_) => IconButton(
                    onPressed: _handleSubmit,
                    icon: Icon(
                      Icons.send,
                      color: context.colorScheme.primary,
                    ),
                  ),
              },
            ),
          );
        },
      ),
    );
  }
}
