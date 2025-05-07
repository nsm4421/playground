part of '../../export.pages.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  static final Duration _duration = 1.sec;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (prev, curr) => (curr.status == Status.error),
      listener: (context, state) {
        if (state.status == Status.error) {
          context.showErrorSnackBar(
              message: 'Sign In Fails', description: state.message);
          Timer(_duration, () {
            context.read<AuthBloc>().add(InitAuthEvent(status: Status.initial));
          });
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return LoadingOverLayWidget(
              isLoading: state.status != Status.initial,
              loadingWidget: const Center(child: CircularProgressIndicator()),
              child: const SignInScreen());
        },
      ),
    );
  }
}
