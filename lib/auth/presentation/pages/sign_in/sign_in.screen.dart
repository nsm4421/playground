part of 'sign_in.page.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  static const int _maxEmailLength = 30;
  static const int _maxPasswordLength = 30;

  late TextEditingController _emailTec;
  late TextEditingController _passwordTec;

  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _emailTec = TextEditingController();
    _passwordTec = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailTec.dispose();
    _passwordTec.dispose();
  }

  _switchVisiblity() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  // TODO : 회원가입 페이지로 이동
  _routeSignUp() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 앱 로고
              Padding(
                padding: EdgeInsets.only(
                    top: CustomSpacing.xxxl * 2, bottom: CustomSpacing.lg),
                child: AppLogoWidget(
                  fit: BoxFit.fitHeight,
                  width: MediaQuery.of(context).size.width * 0.8,
                ),
              ),

              // 이메일
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: CustomSpacing.lg, vertical: CustomSpacing.tiny),
                child: TextFormField(
                  controller: _emailTec,
                  maxLength: _maxEmailLength,
                  maxLines: 1,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),

              // 비밀번호
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: CustomSpacing.lg, vertical: CustomSpacing.tiny),
                child: TextFormField(
                  controller: _passwordTec,
                  maxLength: _maxPasswordLength,
                  maxLines: 1,
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.key),
                      suffixIcon: IconButton(
                        icon: Icon(_isPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: _switchVisiblity,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),

              //  로그인 버튼
              Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: CustomSpacing.xxl,
                      vertical: CustomSpacing.tiny),
                  child: const SignInWithEmailAndPasswordButton()),

              // 회원가입버튼
              Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: CustomSpacing.xxl,
                      vertical: CustomSpacing.tiny),
                  child: ElevatedButton(
                    onPressed: _routeSignUp,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.account_circle_outlined,
                          size: CustomTextSize.xl,
                        ),
                        CustomWidth.xl,
                        const Text('이메일로 회원가입하기'),
                      ],
                    ),
                  )),

              // 디바이더
              Padding(
                padding: EdgeInsets.symmetric(vertical: CustomSpacing.sm),
                child: Divider(
                  thickness: 0.8,
                  indent: CustomSpacing.xl,
                  endIndent: CustomSpacing.xl,
                ),
              ),

              // 구글 로그인 버튼
              Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: CustomSpacing.xxl,
                      vertical: CustomSpacing.tiny),
                  child: const GoogleSignInButton()),

              // 깃허브 로그인 버튼
              Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: CustomSpacing.xxl,
                      vertical: CustomSpacing.tiny),
                  child: const GithubSignInButton()),
            ],
          ),
        ),
      ),
    );
  }
}
