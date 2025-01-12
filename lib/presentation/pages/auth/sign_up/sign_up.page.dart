part of '../../export.pages.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  static final Duration _duration = 1.sec;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (prev, curr) =>
          (curr.status == Status.success) || (curr.status == Status.error),
      listener: (context, state) {
        if (state.status == Status.success) {
          context.showSuccessSnackBar(message: 'Sign Up Success');
          Timer(_duration, () {
            context.read<AuthBloc>().add(InitAuthEvent(status: Status.initial));
            context.replace(Routes.auth.path);
          });
        } else if (state.status == Status.error) {
          context.showErrorSnackBar(
              message: 'Sign Up Fails', description: state.message);
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
              child: const SignUpScreen());
        },
      ),
    );
  }
}
