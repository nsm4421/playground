part of 'index.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            context.pop();
          },
        ),
        title: const Text('Sign Up'),
        actions: [
          GestureDetector(
            onTap: () async {
              FocusScope.of(context).unfocus();
              await Future.delayed(200.ms, () async {
                await context.read<SignUpCubit>().signUp(); // 회원가입 요청
              });
            },
            child: Text(
              "Submit",
              style: context.textTheme.titleMedium
                  ?.copyWith(color: context.colorScheme.secondary),
            ),
          )
        ],
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 80),
              child: SelectAvatarWidget(),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: SignUpFormFragment(),
            ),
          ],
        ),
      ),
    );
  }
}
