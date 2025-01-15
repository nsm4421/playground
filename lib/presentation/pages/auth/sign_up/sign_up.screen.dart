part of '../../export.pages.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Sign Up Page"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              padding:
              const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: context.colorScheme.primaryContainer.withOpacity(0.5)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Profile Image",
                    style: context.textTheme.titleLarge,
                  ),
                  (16.height),
                  const Center(child: ProfileImageFragment()),
                ],
              ),
            ),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color:
                        context.colorScheme.primaryContainer.withOpacity(0.5)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Form",
                      style: context.textTheme.titleLarge,
                    ),
                    (12.height),
                    const SignUpFormFragment(),
                  ],
                )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () async {
          // 회원 가입 양식 제출
          FocusScope.of(context).unfocus();
          await context.read<SignUpCubit>().submit();
        },
        child: const Icon(Icons.chevron_right),
      ),
    );
  }
}
