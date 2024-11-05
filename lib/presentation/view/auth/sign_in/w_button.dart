part of 'index.dart';

class SubmitButtonWidget extends StatelessWidget {
  const SubmitButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInCubit, SignInState>(
      builder: (context, state) {
        return ElevatedButton(
          // 회원가입 처리
          onPressed: state.status == Status.loading
              ? null
              : () async {
                  FocusScope.of(context).unfocus();
                  if (context.read<SignInCubit>().ok) {
                    await Future.delayed(200.ms, () async {
                      await context.read<SignInCubit>().signIn();
                    });
                  }
                },
          style: ElevatedButton.styleFrom(
              backgroundColor:
                  context.colorScheme.primaryContainer.withOpacity(0.5),
              minimumSize: const Size(double.infinity, 50)),
          child: Text(
            'Submit',
            style: context.textTheme.titleMedium
                ?.copyWith(color: context.colorScheme.onPrimary),
          ),
        );
      },
    );
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
                      // 회원가입페이지로 이동
                      context.push(Routes.signUp.path);
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
      bottom: -25,
      child: CircleAvatar(
        radius: 25,
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
