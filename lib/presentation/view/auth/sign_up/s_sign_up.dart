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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            (80.0).h,
            SelectAvatarWidget(),
            (20.0).h,
            SignUpFormFragment(),
          ],
        ),
      ),
      floatingActionButton: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SubmitButtonWidget(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
