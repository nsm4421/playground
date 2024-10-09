part of 'page.dart';

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

  _switchVisible() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  String? _handleValidateEmail(String? text) {
    if (text == null || text.isEmpty) return '이메일을 입력하세요';
    return customUtil.validateEmail(text) ? null : '올바른 이메일 형식이 아닙니다';
  }

  String? _handleValidatePassword(String? text) {
    return (text == null || text.isEmpty) ? '비밀번호를 입력하세요' : null;
  }

  _handleClearEmail() {
    _emailTec.clear();
  }

  _routeSignUp() {
    context
        .read<AuthenticationBloc>()
        .add(InitializeEvent(step: AuthenticationStep.signUp));
  }

  _submitForm() async {
    if (!context.read<AuthenticationBloc>().state.status.ok) return;
    final ok = _formKey.currentState?.validate();
    if (ok == null || !ok) return;
    _formKey.currentState?.save();
    context.read<AuthenticationBloc>().add(SignInWithEmailAndPasswordEvent(
        email: _emailTec.text.trim(), password: _passwordTec.text.trim()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(children: [
      Padding(
          padding: const EdgeInsets.symmetric(vertical: 60),
          child: Text('Login',
              style: Theme.of(context)
                  .textTheme
                  .displayMedium
                  ?.copyWith(fontWeight: FontWeight.bold))),

      // 이메일, 비밀번호
      Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                child: CustomTextFieldWidget(
                  _emailTec,
                  prefixIcon: Icons.email,
                  validator: _handleValidateEmail,
                  maxLength: _maxEmailLength,
                  suffixIcon: Icons.clear,
                  onTapSuffixIcon: _handleClearEmail,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                child: CustomTextFieldWidget(
                  _passwordTec,
                  obscureText: !_isPasswordVisible,
                  prefixIcon: Icons.key,
                  validator: _handleValidatePassword,
                  maxLength: _maxPasswordLength,
                  suffixIcon: _isPasswordVisible
                      ? Icons.visibility_off
                      : Icons.visibility,
                  onTapSuffixIcon: _switchVisible,
                ),
              ),
            ],
          )),

      /// 버튼
      Column(
        children: [
          //  로그인 버튼
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 3),
              child: ElevatedButton(
                  onPressed: _submitForm,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.email, size: 20),
                        const SizedBox(width: 20),
                        Text('Sign In',
                            style: Theme.of(context).textTheme.titleMedium)
                      ]))),

          const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
              child: Divider()),

          // 회원가입버튼
          const Text("Want to make account?"),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 3),
              child: ElevatedButton(
                  onPressed: _routeSignUp,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.account_circle_outlined, size: 20),
                        const SizedBox(width: 20),
                        Text('Sign Up',
                            style: Theme.of(context).textTheme.titleMedium)
                      ])))
        ],
      )
    ]))));
  }
}
