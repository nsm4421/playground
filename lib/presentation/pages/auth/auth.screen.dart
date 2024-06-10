part of 'auth.page.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  _handleGoogleSignIn() {
    context.read<UserBloc>().add(SignInWithGoogleEvent());
  }

  _handleMoveToSignUpWithEmailAndPassword() {
    context.push(Routes.signUpWithEmailAndPassword.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("로그인 페이지")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 이메일, 비밀번호 로그인
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
              child: SignInWithEmailAndPasswordFragment(),
            ),

            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 3,
                  child: const Divider(indent: 10),
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    child: Center(
                        child: Text("소셜 로그인",
                            style: Theme.of(context).textTheme.titleLarge))),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 3,
                  child: const Divider(endIndent: 10),
                ),
              ],
            ),

            // 구글 로그인 버튼
            Padding(
              padding: const EdgeInsets.only(
                  left: 15, right: 15, top: 10, bottom: 30),
              child: ElevatedButton(
                  onPressed: _handleGoogleSignIn,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FaIcon(FontAwesomeIcons.google),
                      SizedBox(width: 10),
                      Text("구글계정으로 로그인"),
                    ],
                  )),
            ),

            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 3,
                  child: const Divider(indent: 10),
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    child: Center(
                        child: Text("회원가입",
                            style: Theme.of(context).textTheme.titleLarge))),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 3,
                  child: const Divider(endIndent: 10),
                ),
              ],
            ),

            // 이메일 비멀번호 회원가입
            Padding(
              padding: const EdgeInsets.only(
                  left: 15, right: 15, top: 10, bottom: 30),
              child: ElevatedButton(
                  onPressed: _handleMoveToSignUpWithEmailAndPassword,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.email_outlined),
                      SizedBox(width: 10),
                      Text("이메일 & 비밀번호 회원가입"),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
