part of '../page.dart';

class EditCommentWidget extends StatefulWidget {
  const EditCommentWidget({super.key});

  @override
  State<EditCommentWidget> createState() => _EditCommentWidgetState();
}

class _EditCommentWidgetState extends State<EditCommentWidget> {
  static const _maxLength = 100;
  static const _minLine = 1;
  static const _maxLine = 3;
  late TextEditingController _tec;

  @override
  void initState() {
    super.initState();
    _tec = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _tec.dispose();
  }

  _handleSubmit() {
    final text = _tec.text.trim();
    if (_tec.text.trim().isNotEmpty) {
      context
          .read<EditCommentBloc<MeetingEntity>>()
          .add(CreateCommentEvent(text));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditCommentBloc<MeetingEntity>, EditCommentState>(
        listener: (context, state) {
      switch (state.status) {
        // 댓글작성 성공 -> 새로고침
        case Status.success:
          context
              .read<DisplayCommentBloc<MeetingEntity>>()
              .add(FetchEvent<CommentEntity>(refresh: true));
          _tec.clear();
        // 댓글작성 오류 -> 에러메세지, 초기화
        case Status.error:
          customUtil.showErrorSnackBar(
              context: context, message: state.errorMessage);
          Timer(const Duration(seconds: 1), () {
            context.read<EditCommentBloc>().add(
                InitCommentEvent(status: Status.initial, errorMessage: ''));
          });
        default:
          return;
      }
    }, child: BlocBuilder<EditCommentBloc<MeetingEntity>, EditCommentState>(
            builder: (context, state) {
      return TextField(
          controller: _tec,
          minLines: _minLine,
          maxLines: _maxLine,
          maxLength: _maxLength,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.secondary,
              letterSpacing: 1.5,
              wordSpacing: 3,
              fontWeight: FontWeight.w500),
          decoration: InputDecoration(
              border: const OutlineInputBorder(),
              suffixIcon: state.status == Status.loading
                  ? Transform.scale(
                      scale: 0.5, child: const CircularProgressIndicator())
                  : IconButton(
                      onPressed: _handleSubmit,
                      icon: Icon(Icons.send,
                          color: Theme.of(context).colorScheme.primary)),
              hintStyle: Theme.of(context).textTheme.labelMedium,
              helperStyle: Theme.of(context).textTheme.labelMedium,
              hintText: 'send comment',
              helperText: 'max length is $_maxLength characters'));
    }));
  }
}
