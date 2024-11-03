part of 'index.dart';

class SubmitButtonWidget extends StatelessWidget {
  const SubmitButtonWidget(this._formKey, {super.key});

  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInCubit, SignInState>(builder: (context, state) {
      return ElevatedButton(
          // 회원가입 처리
          onPressed: state.status == Status.loading
              ? null
              : () async {
                  // 폼 검사
                  _formKey.currentState?.save();
                  final ok = _formKey.currentState?.validate();
                  if (ok == null || !ok) {
                    return;
                  }
                  // 회원가입 요청
                  await context.read<SignInCubit>().signIn();
                },
          style: ElevatedButton.styleFrom(
              backgroundColor:
                  context.colorScheme.primaryContainer.withOpacity(0.5),
              minimumSize: const Size(double.infinity, 50)),
          child: Text(
            'Sign In',
            style: context.textTheme.titleMedium
                ?.copyWith(color: context.colorScheme.onPrimary),
          ));
    });
  }
}

class RouteToSignUpButtonWidget extends StatelessWidget {
  const RouteToSignUpButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInCubit, SignInState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "if you don't have account yet",
              style: context.textTheme.labelLarge,
            ),
            (12.0).h,
            ElevatedButton(
              onPressed: state.status == Status.loading
                  ? null
                  : () {
                      // TODO : 회원가입 페이지로 이동하기
                    },
              style: ElevatedButton.styleFrom(
                  backgroundColor:
                      context.colorScheme.secondaryContainer.withOpacity(0.5),
                  minimumSize: const Size(double.infinity, 50)),
              child: Text(
                'Sign Up',
                style: context.textTheme.titleMedium
                    ?.copyWith(color: context.colorScheme.onSecondary),
              ),
            ),
          ],
        );
      },
    );
  }
}

class CloseButtonWidget extends StatelessWidget {
  const CloseButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: -50,
      child: CircleAvatar(
        radius: 50 / 2,
        backgroundColor: CustomPalette.white,
        child: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(
            Icons.clear,
            color: CustomPalette.black.withOpacity(0.8),
          ),
        ),
      ),
    );
  }
}
