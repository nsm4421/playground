part of 'index.dart';

class FabWidget extends StatelessWidget {
  const FabWidget({super.key});

  static const double _size = 30;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: InkWell(
        onTap: () async {
          FocusScope.of(context).unfocus();
          await Future.delayed(200.ms, () {
            context.read<CreateFeedBloc>().add(SubmitEvent());
          });
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.colorScheme.primaryContainer),
          child: Icon(
            Icons.chevron_right_rounded,
            color: context.colorScheme.onPrimary,
            size: _size,
          ),
        ),
      ),
    );
  }
}
