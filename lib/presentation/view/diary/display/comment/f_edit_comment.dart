part of 'page.dart';

class EditCommentFragment extends StatefulWidget {
  const EditCommentFragment({super.key});

  @override
  State<EditCommentFragment> createState() => _EditCommentFragmentState();
}

class _EditCommentFragmentState extends State<EditCommentFragment> {
  static const int _minLine = 1;
  static const int _maxLine = 5;
  static const int _maxLength = 300;
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
    if (text.isNotEmpty) {
      context
          .read<EditCommentBloc<DiaryEntity>>()
          .add(CreateCommentEvent(text));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditCommentBloc<DiaryEntity>, EditCommentState>(
      listener: (context, state) {
        if (state.status == Status.success) {
          _tec.clear();
          Timer(const Duration(seconds: 1), () {
            context
                .read<DisplayCommentBloc<DiaryEntity>>()
                .add(FetchEvent<CommentEntity>(refresh: true));
          });
        } else if (state.status == Status.error) {
          customUtil.showErrorSnackBar(
              context: context, message: state.errorMessage);
          Timer(const Duration(seconds: 1), () {
            context.read<EditCommentBloc<DiaryEntity>>().add(
                InitCommentEvent(status: Status.initial, errorMessage: ''));
          });
        }
      },
      child: BlocBuilder<EditCommentBloc<DiaryEntity>, EditCommentState>(
          builder: (context, state) {
        return TextField(
            readOnly: !state.status.ok,
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
                        icon: Icon(Icons.chevron_right_rounded,
                            color: Theme.of(context).colorScheme.primary)),
                hintStyle: Theme.of(context).textTheme.labelMedium,
                helperStyle: Theme.of(context).textTheme.labelMedium,
                hintText: 'send comment',
                helperText: 'max length is $_maxLength characters'));
      }),
    );
  }
}
