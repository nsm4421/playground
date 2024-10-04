part of '../auth.page.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // 글자수 제한
  static const _maxEmailLength = 30;
  static const _maxPasswordLength = 30;
  static const _minUsernameLength = 3;
  static const _maxUsernameLength = 15;

  // text editing controller
  late TextEditingController _emailTec;
  late TextEditingController _passwordTec;
  late TextEditingController _passwordConfirmTec;
  late TextEditingController _usernameTec;

  // hint text
  String? _helperTextOnEmail;
  String? _helperTextOnPassword;
  String? _helperTextOnPasswordConfirm;
  String? _helperTextOnUsername;

  // 기타
  late GlobalKey<FormState> _formKey;
  File? _selectedImage; // 프로필 이미지
  bool _isPasswordVisible = false;
  bool _isPasswordConfirmVisible = false;
  bool _isCheckingUsername = false;

  @override
  void initState() {
    super.initState();
    _emailTec = TextEditingController();
    _passwordTec = TextEditingController();
    _passwordConfirmTec = TextEditingController();
    _usernameTec = TextEditingController();
    _formKey = GlobalKey<FormState>(debugLabel: 'sign-up-form-key');
  }

  @override
  dispose() {
    super.dispose();
    _emailTec.dispose();
    _passwordTec.dispose();
    _passwordConfirmTec.dispose();
    _usernameTec.dispose();
  }

  _handleGoBack() {
    context
        .read<AuthenticationBloc>()
        .add(InitializeEvent(step: AuthenticationStep.signIn));
  }

  _switchPasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  _switchPasswordConfirmVisibility() {
    setState(() {
      _isPasswordConfirmVisible = !_isPasswordConfirmVisible;
    });
  }

  String? _validateEmail(String? text) {
    if (text == null || text.isEmpty) {
      return '이메일을 입력하세요';
    } else {
      return customUtil.validateEmail(text) ? null : '올바른 이메일 형식이 아닙니다';
    }
  }

  _handleHelperTextOnEmail() {
    setState(() {
      _helperTextOnEmail = _validateEmail(_emailTec.text.trim());
    });
  }

  String? _validatePassword(String? text) {
    return text == null || text.isEmpty ? '비밀번호를 입력하세요' : null;
  }

  _handleHelperTextOnPassword() {
    setState(() {
      _helperTextOnPassword = _validatePassword(_passwordTec.text.trim());
    });
  }

  String? _validatePasswordConfirm(String? text) {
    if (text == null || text.isEmpty) {
      return '비밀번호를 다시 입력하세요';
    } else if (_passwordTec.text.trim() != text) {
      return '비밀번호가 일치하지 않습니다';
    } else {
      return null;
    }
  }

  _handleHelperTextOnPasswordConfirm() {
    setState(() {
      _helperTextOnPasswordConfirm =
          _validatePasswordConfirm(_passwordConfirmTec.text.trim());
    });
  }

  String? _validateUsername(String? text) {
    if (text == null || text.isEmpty) {
      return '유저명을 입력하세요';
    } else if (text.length < _minUsernameLength ||
        text.length > _maxUsernameLength) {
      return '유저명은 최소 $_minUsernameLength~$_maxUsernameLength글자로 작명해주세요';
    }
    return null;
  }

  _handleHelperTextOnUsername() async {
    final username = _usernameTec.text.trim();
    if (_isCheckingUsername || username.isEmpty) return;
    setState(() {
      _isCheckingUsername = true;
    });
    return await context
        .read<AuthenticationBloc>()
        .isUsernameDuplicated(username)
        .then((isDuplicated) {
      setState(() {
        _isCheckingUsername = false;
        _helperTextOnUsername =
            isDuplicated ? '$username은 중복된 유저명입니다' : '$username은 사용 가능한 유저명입니다';
      });
    });
  }

  _handleOnSelect(File? file) {
    _selectedImage = file;
  }

  handleSignUp() async {
    if (_selectedImage == null) {
      customUtil.showWarningSnackBar(
          context: context, message: '프로필 사진을 선택해주세요');
      return;
    }
    // 입력값 검사
    final ok = _formKey.currentState?.validate();
    if (ok == null || !ok) {
      return;
    }
    _formKey.currentState?.save();
    // 회원가입 처리
    context.read<AuthenticationBloc>().add(SignUpWithEmailAndPasswordEvent(
        email: _emailTec.text.trim(),
        password: _passwordTec.text.trim(),
        username: _usernameTec.text.trim(),
        profileImage: _selectedImage!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.chevron_left), onPressed: _handleGoBack),
          title: const Text('Sign Up'),
          elevation: 0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
              child: Column(children: [
            /// 프로필 사진 선택
            Padding(
                padding: const EdgeInsets.only(top: 50, bottom: 30),
                child: SelectAvatarWidget(_selectedImage, _handleOnSelect,
                    size: MediaQuery.of(context).size.width / 2)),

            /// 유저 정보
            Form(
              key: _formKey,
              child: Column(children: [
                // 이메일
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                  child: CustomTextFieldWidget(
                    _emailTec,
                    hintText: 'press email to confirm',
                    maxLength: _maxEmailLength,
                    prefixIcon: Icons.email,
                    helperText: _helperTextOnEmail,
                    onFocusLeave: _handleHelperTextOnEmail,
                    validator: _validateEmail,
                  ),
                ),
                // 비밀번호
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                  child: CustomTextFieldWidget(
                    _passwordTec,
                    hintText: 'password',
                    maxLength: _maxPasswordLength,
                    prefixIcon: Icons.key,
                    suffixIcon: _isPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility,
                    helperText: _helperTextOnPassword,
                    onFocusLeave: _handleHelperTextOnPassword,
                    validator: _validatePassword,
                    obscureText: !_isPasswordVisible,
                    onTapSuffixIcon: _switchPasswordVisibility,
                  ),
                ),

                // 비밀번호 확인
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                  child: CustomTextFieldWidget(
                    _passwordConfirmTec,
                    hintText: 'press password again',
                    maxLength: _maxPasswordLength,
                    prefixIcon: Icons.key,
                    suffixIcon: _isPasswordConfirmVisible
                        ? Icons.visibility_off
                        : Icons.visibility,
                    helperText: _helperTextOnPasswordConfirm,
                    onFocusLeave: _handleHelperTextOnPasswordConfirm,
                    validator: _validatePasswordConfirm,
                    obscureText: !_isPasswordConfirmVisible,
                    onTapSuffixIcon: _switchPasswordConfirmVisibility,
                  ),
                ),

                // 유저명
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                  child: CustomTextFieldWidget(
                    _usernameTec,
                    hintText: 'press username',
                    maxLength: _maxUsernameLength,
                    prefixIcon: Icons.account_box_outlined,
                    helperText: _helperTextOnUsername,
                    onFocusLeave: _handleHelperTextOnUsername,
                    validator: _validateUsername,
                    isLoading: _isCheckingUsername,
                    suffixIcon: _isCheckingUsername ? null : Icons.check,
                    onTapSuffixIcon: _handleHelperTextOnEmail,
                  ),
                ),

                const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    child: Divider()),

                // 회원가입 버튼
                Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: ElevatedButton(
                        onPressed: handleSignUp,
                        child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.check, size: 20),
                              SizedBox(width: 20),
                              Text('회원가입하기', style: TextStyle(fontSize: 20))
                            ])))
              ]),
            )
          ])),
        ));
  }
}
