part of '../widget.dart';

class EditCommentWidget<RefEntity extends BaseEntity> extends StatefulWidget {
  const EditCommentWidget({super.key, this.maxLength = 500, this.maxLines = 3});

  final int maxLength;
  final int maxLines;

  @override
  State<EditCommentWidget<RefEntity>> createState() =>
      _EditCommentWidgetState<RefEntity>();
}

class _EditCommentWidgetState<RefEntity extends BaseEntity>
    extends State<EditCommentWidget<RefEntity>> {
  int _textLength = 0;
  late TextEditingController _controller;
  late FocusNode _focusNode;
  late String _commentId;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode()..addListener(_handleFocus);
    _commentId = context.read<CreateCommentCubit<RefEntity>>().commentId;
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
          .read<CreateCommentCubit<RefEntity>>()
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
          .read<CreateCommentCubit<RefEntity>>()
          .handleSubmitParentComment();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateCommentCubit<RefEntity>,
        CreateCommentState<RefEntity>>(
      listener: (context, state) async {
        if (state.status == Status.success) {
          _controller.clear();
          // TODO : 댓글 추가
          _commentId = context.read<CreateCommentCubit<RefEntity>>().commentId;
        } else if (state.status == Status.error) {
          getIt<CustomSnackBar>()
              .error(title: 'Error', description: state.message);
          await Future.delayed(200.ms, () {
            context
                .read<CreateCommentCubit<RefEntity>>()
                .initState(status: Status.initial, message: '');
          });
        }
      },
      child: BlocBuilder<CreateCommentCubit<RefEntity>,
          CreateCommentState<RefEntity>>(
        builder: (context, state) {
          return TextField(
            onChanged: _handleOnChange,
            focusNode: _focusNode,
            controller: _controller,
            maxLength: widget.maxLength,
            minLines: 1,
            maxLines: widget.maxLines,
            decoration: InputDecoration(
              label: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Content  ',
                      style: context.textTheme.bodyMedium,
                    ),
                    TextSpan(
                      text: '($_textLength/${widget.maxLength})',
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
