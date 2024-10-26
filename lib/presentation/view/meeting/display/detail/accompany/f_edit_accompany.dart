part of '../page.dart';

class EditAccompanyFragment extends StatefulWidget {
  const EditAccompanyFragment({super.key});

  @override
  State<EditAccompanyFragment> createState() => _EditAccompanyFragmentState();
}

class _EditAccompanyFragmentState extends State<EditAccompanyFragment> {
  static const _maxLength = 50;
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
      context.read<EditRegistrationBloc>().add(RegisterMeetingEvent(text));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditRegistrationBloc, EditRegistrationState>(
        listener: (context, state) {
      if (state.status == Status.success) {
        // 성공 시 새로고침
        context
            .read<DisplayRegistrationBloc>()
            .add(FetchEvent<RegistrationEntity>(refresh: true));
      } else if (state.status == Status.error) {
        customUtil.showErrorSnackBar(
            context: context, message: state.errorMessage);
        Timer(const Duration(seconds: 1), () {
          context.read<EditRegistrationBloc>().add(InitEditRegistrationEvent(
              status: Status.initial, errorMessage: ''));
        });
      }
    }, child: BlocBuilder<EditRegistrationBloc, EditRegistrationState>(
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
                    icon: Icon(Icons.chevron_right_rounded,
                        color: Theme.of(context).colorScheme.primary)),
            hintStyle: Theme.of(context).textTheme.labelMedium,
            helperStyle: Theme.of(context).textTheme.labelMedium,
            hintText: 'i want to join',
            helperText: 'max length is $_maxLength characters'),
      );
    }));
  }
}
