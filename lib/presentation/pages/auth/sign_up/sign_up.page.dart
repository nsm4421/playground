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
          Timer(_duration, () {
            // TODO : 성공 메세지 띄우기
            context.read<AuthBloc>().add(InitEvent(status: Status.initial));
            context.replace(Routes.auth.path);
          });
        } else if (state.status == Status.error) {
          Timer(_duration, () {
            // TODO : 에러 메세지 띄우기
            context.read<AuthBloc>().add(InitEvent(status: Status.initial));
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
