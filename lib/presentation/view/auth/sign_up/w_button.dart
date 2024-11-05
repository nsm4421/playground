part of 'index.dart';

class SubmitButtonWidget extends StatelessWidget {
  const SubmitButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor:
            context.colorScheme.secondaryContainer.withOpacity(0.8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        elevation: 5,
      ),
      onPressed: () async {
        FocusScope.of(context).unfocus();
        await Future.delayed(200.ms, () async {
          await context.read<SignUpCubit>().signUp(); // 회원가입 요청
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Submit",
              style: context.textTheme.titleMedium
                  ?.copyWith(color: context.colorScheme.onSecondary)),
        ],
      ),
    );
  }
}
