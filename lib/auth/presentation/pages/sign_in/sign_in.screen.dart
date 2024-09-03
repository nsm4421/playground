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
  late GlobalKey<FormState> _formKey;

  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _emailTec = TextEditingController();
    _passwordTec = TextEditingController();
    _formKey = GlobalKey<FormState>(debugLabel: 'login form');
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

  String? _validateEmail(String? text) {
    RegExp regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (text == null || text.isEmpty) {
      return '이메일을 입력하세요';
    } else if (!regex.hasMatch(text)) {
      return '올바른 이메일 형식이 아닙니다';
    }
    return null;
  }

  String? _validatePassword(String? text) {
    if (text == null || text.isEmpty) {
      return '비밀번호를 입력하세요';
    }
    return null;
  }

  // TODO : 회원가입 페이지로 이동
  _routeSignUp() {}

  _submitForm() async {
    // 이메일, 비밀번호 필드 검사
    final ok = _formKey.currentState?.validate();
    if (ok == null || !ok) {
      return;
    }
    _formKey.currentState?.save();
    await context.read<SignInCubit>().signInWithEmailAndPassword(
        _emailTec.text.trim(), _passwordTec.text.trim());
  }

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

              // 이메일, 비밀번호
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: CustomSpacing.lg,
                            vertical: CustomSpacing.tiny),
                        child: TextFormField(
                          controller: _emailTec,
                          validator: _validateEmail,
                          maxLength: _maxEmailLength,
                          maxLines: 1,
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.email),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: CustomSpacing.lg,
                            vertical: CustomSpacing.tiny),
                        child: TextFormField(
                          controller: _passwordTec,
                          validator: _validatePassword,
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
                    ],
                  )),

              //  로그인 버튼
              Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: CustomSpacing.xxl,
                      vertical: CustomSpacing.tiny),
                  child: ElevatedButton(
                      onPressed: _submitForm,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.email,
                            size: CustomTextSize.xl,
                          ),
                          CustomWidth.xl,
                          const Text('이메일로 로그인하기'),
                        ],
                      ))),

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
