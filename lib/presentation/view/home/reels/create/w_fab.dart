part of 'index.dart';

class SubmitButtonWidget extends StatelessWidget {
  const SubmitButtonWidget({super.key});

  static const double _iconSize = 40;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateReelsBloc, CreateReelsState>(
        builder: (context, state) {
      final visible = state.status == Status.initial && state.video != null;
      return visible
          ? GestureDetector(
              onTap: () async {
                FocusScope.of(context).unfocus();
                await Future.delayed(200.ms, () {
                  context.read<CreateReelsBloc>().add(SubmitEvent());
                });
              },
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.colorScheme.primaryContainer,
                ),
                child: Icon(
                  Icons.upload,
                  color: context.colorScheme.onPrimary,
                  size: _iconSize,
                ),
              ),
            )
          : const SizedBox();
    });
  }
}
