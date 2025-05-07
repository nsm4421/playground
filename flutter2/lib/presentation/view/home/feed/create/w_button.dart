part of 'index.dart';

class PopButtonWidget extends StatelessWidget {
  const PopButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateFeedBloc, CreateFeedState>(
      builder: (context, state) {
        return ShadowedIconButton(
          onTap: () {
            context.pop();
          },
          iconData: Icons.clear,
          iconSize: 30,
          iconColor:
              state.images.isEmpty ? CustomPalette.white : CustomPalette.black,
          shadowColor:
              state.images.isEmpty ? CustomPalette.shadow : CustomPalette.white,
        );
      },
    );
  }
}

class JumpButtonWidget extends StatelessWidget {
  const JumpButtonWidget(this.handleJumpPage, {super.key});

  final void Function() handleJumpPage;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateFeedBloc, CreateFeedState>(
      builder: (context, state) {
        return ShadowedIconButton(
          onTap: handleJumpPage,
          iconData: Icons.arrow_forward,
          iconSize: 30,
          iconColor:
              state.images.isEmpty ? CustomPalette.white : CustomPalette.black,
          shadowColor:
              state.images.isEmpty ? CustomPalette.shadow : CustomPalette.white,
        );
      },
    );
  }
}

class SubmitFabWidget extends StatelessWidget {
  const SubmitFabWidget({super.key});

  static const double _size = 30;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: RoundedIconWidget(
        onTap: () async {
          FocusScope.of(context).unfocus();
          await Future.delayed(200.ms, () {
            context.read<CreateFeedBloc>().add(SubmitEvent());
          });
        },
        iconData: Icons.chevron_right,
        size: _size,
        bgColor: context.colorScheme.primary,
        iconColor: context.colorScheme.onPrimary,
      ),
    );
  }
}
