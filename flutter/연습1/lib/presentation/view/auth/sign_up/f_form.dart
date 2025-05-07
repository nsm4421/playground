part of 'index.dart';

class SignUpFormFragment extends StatefulWidget {
  const SignUpFormFragment({super.key});

  @override
  State<SignUpFormFragment> createState() => _SignUpFormFragmentState();
}

class _SignUpFormFragmentState extends State<SignUpFormFragment> {
  // 이메일
  static const _emailMaxLength = 30;
  final _emailRegex =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  late TextEditingController _emailController;
  late FocusNode _emailFocus;
  String? _emailHelperText;

  // 비밀번호
  static const _passwordMinLength = 5;
  static const _passwordMaxLength = 30;
  late TextEditingController _passwordController;
  late FocusNode _passwordFocus;
  bool _isPasswordVisible = false;
  String? _passwordHelperText;

  // 비밀번호 확인
  late TextEditingController _passwordConfirmController;
  late FocusNode _passwordConfirmFocus;
  bool _isPasswordConfirmVisible = false;
  String? _passwordConfirmHelperText;

  // 비밀번호
  static const _usernameMinLength = 2;
  static const _usernameMaxLength = 10;
  late TextEditingController _usernameController;
  late FocusNode _usernameFocus;
  String? _usernameHelperText;

  @override
  void initState() {
    super.initState();
    _emailController =
        TextEditingController(text: context.read<SignUpCubit>().state.email);
    _passwordController =
        TextEditingController(text: context.read<SignUpCubit>().state.password);
    _passwordConfirmController =
        TextEditingController(text: context.read<SignUpCubit>().state.password);
    _usernameController =
        TextEditingController(text: context.read<SignUpCubit>().state.username);
    _emailFocus = FocusNode(debugLabel: 'sign-up-email-text-field')
      ..addListener(_handleEmailFocus);
    _passwordFocus = FocusNode(debugLabel: 'sign-up-password-text-field')
      ..addListener(_handlePasswordFocus);
    _passwordConfirmFocus =
        FocusNode(debugLabel: 'sign-up-password-confirm-text-field')
          ..addListener(_handlePasswordConfirmFocus);
    _usernameFocus = FocusNode(debugLabel: 'sign-up-username-text-field')
      ..addListener(_handleUsernameFocus);
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    _usernameController.dispose();
    _emailFocus
      ..removeListener(_handleEmailFocus)
      ..dispose();
    _passwordFocus
      ..removeListener(_handlePasswordFocus)
      ..dispose();
    _passwordConfirmFocus
      ..removeListener(_handlePasswordConfirmFocus)
      ..dispose();
    _usernameFocus
      ..removeListener(_handleUsernameFocus)
      ..dispose();
  }

  _handleEmailFocus() {
    final email = _emailController.text.trim();
    setState(() {
      _emailHelperText = email.isEmpty ? null : _handleValidateEmail(email);
    });
    if (!_emailFocus.hasFocus) {
      context.read<SignUpCubit>().edit(email: _emailController.text.trim());
    }
  }

  _handlePasswordFocus() {
    final password = _passwordController.text.trim();
    setState(() {
      _passwordHelperText = password.isEmpty
          ? 'password character must consist of $_passwordMinLength~$_passwordMaxLength'
          : (_handleValidatePassword(password) ?? 'good to go');
      _isPasswordVisible = _passwordFocus.hasFocus;
    });
    if (!_passwordFocus.hasFocus) {
      context
          .read<SignUpCubit>()
          .edit(password: _passwordController.text.trim());
    }
  }

  _handlePasswordConfirmFocus() {
    final passwordConfirm = _passwordConfirmController.text.trim();
    setState(() {
      _passwordConfirmHelperText = passwordConfirm.isEmpty
          ? 'press password again'
          : (_handleValidateConfirmPassword(passwordConfirm) ?? 'good to go');
      _isPasswordVisible = _passwordFocus.hasFocus;
    });
    setState(() {
      _isPasswordConfirmVisible = _passwordConfirmFocus.hasFocus;
    });
  }

  _handleUsernameFocus() {
    final username = _usernameController.text.trim();
    setState(() {
      _usernameHelperText = username.isEmpty
          ? 'username character must consist of $_usernameMinLength~$_usernameMaxLength'
          : (_handleValidateUsername(username) ?? 'good to go');
    });
    if (!_usernameFocus.hasFocus) {
      context.read<SignUpCubit>().edit(username: username);
    }
  }

  String? _handleValidateEmail(String? text) {
    if (text == null || text.isEmpty) {
      return 'send email';
    } else if (!_emailRegex.hasMatch(text)) {
      return 'not valid email';
    }
    return null;
  }

  String? _handleValidatePassword(String? text) {
    if (text == null || text.isEmpty) {
      return 'send password';
    } else if (text.length < _passwordMinLength) {
      return 'password is too short';
    } else if (text.length > _passwordMaxLength) {
      return 'password is too long';
    }
    return null;
  }

  String? _handleValidateConfirmPassword(String? text) {
    if (text == null || text.isEmpty) {
      return null;
    } else if (text != _passwordController.text) {
      return 'password is not matched';
    }
    return null;
  }

  String? _handleValidateUsername(String? text) {
    if (text == null || text.isEmpty) {
      return 'send password';
    } else if (text.length < _usernameMinLength) {
      return 'username is too short';
    } else if (text.length > _usernameMaxLength) {
      return 'username is too long';
    }
    return null;
  }

  _handleClearEmail() {
    _emailController.clear();
  }

  _handleClearPassword() {
    _passwordController.clear();
  }

  _handleClearPasswordConfirm() {
    _passwordConfirmController.clear();
  }

  _handleClearUsername() {
    _usernameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Form(
          key: context.read<SignUpCubit>().formKey,
          child: Column(
            children: [
              /// 이메일
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: TextFormField(
                  controller: _emailController,
                  validator: _handleValidateEmail,
                  focusNode: _emailFocus,
                  maxLength: _emailMaxLength,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.email_outlined,
                          color: _emailFocus.hasFocus
                              ? context.colorScheme.primary.withOpacity(0.5)
                              : null,
                        ),
                      ),
                      suffixIcon: IconButton(
                        onPressed: _handleClearEmail,
                        icon: Icon(
                          Icons.clear,
                          color: _emailFocus.hasFocus
                              ? context.colorScheme.primary.withOpacity(0.5)
                              : null,
                        ),
                      ),
                      labelText: 'Email',
                      helperText: _emailHelperText,
                      helperStyle: _emailFocus.hasFocus
                          ? context.textTheme.labelLarge
                              ?.copyWith(color: CustomPalette.mediumGrey)
                          : null,
                      counterText: ''),
                ),
              ),

              /// 비밀번호
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: TextFormField(
                  controller: _passwordController,
                  validator: _handleValidatePassword,
                  obscureText: !_isPasswordVisible,
                  focusNode: _passwordFocus,
                  maxLength: _passwordMaxLength,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.key_outlined,
                            color: _passwordFocus.hasFocus
                                ? context.colorScheme.primary.withOpacity(0.5)
                                : null),
                      ),
                      suffixIcon: IconButton(
                        onPressed: _handleClearPassword,
                        icon: Icon(
                          Icons.clear,
                          color: _passwordFocus.hasFocus
                              ? context.colorScheme.primary.withOpacity(0.5)
                              : null,
                        ),
                      ),
                      labelText: 'Password',
                      helperText: _passwordHelperText,
                      helperStyle: _passwordFocus.hasFocus
                          ? context.textTheme.labelLarge
                              ?.copyWith(color: CustomPalette.mediumGrey)
                          : null,
                      counterText: ''),
                ),
              ),

              /// 비밀번호 확인
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: TextFormField(
                  controller: _passwordConfirmController,
                  validator: _handleValidateConfirmPassword,
                  obscureText: !_isPasswordConfirmVisible,
                  focusNode: _passwordConfirmFocus,
                  maxLength: _passwordMaxLength,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.key_outlined,
                            color: _passwordConfirmFocus.hasFocus
                                ? context.colorScheme.primary.withOpacity(0.5)
                                : null),
                      ),
                      suffixIcon: IconButton(
                        onPressed: _handleClearPasswordConfirm,
                        icon: Icon(
                          Icons.clear,
                          color: _passwordConfirmFocus.hasFocus
                              ? context.colorScheme.primary.withOpacity(0.5)
                              : null,
                        ),
                      ),
                      labelText: 'Password Confirm',
                      helperText: _passwordConfirmHelperText,
                      helperStyle: _passwordConfirmFocus.hasFocus
                          ? context.textTheme.labelLarge
                              ?.copyWith(color: CustomPalette.mediumGrey)
                          : null,
                      counterText: ''),
                ),
              ),

              /// 유저명
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: TextFormField(
                  controller: _usernameController,
                  validator: _handleValidateUsername,
                  focusNode: _usernameFocus,
                  maxLength: _usernameMaxLength,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.abc,
                            color: _usernameFocus.hasFocus
                                ? context.colorScheme.primary.withOpacity(0.5)
                                : null),
                      ),
                      suffixIcon: IconButton(
                          onPressed: _handleClearUsername,
                          icon: Icon(
                            Icons.clear,
                            color: _usernameFocus.hasFocus
                                ? context.colorScheme.primary.withOpacity(0.5)
                                : null,
                          )),
                      labelText: 'Username',
                      helperText: _usernameHelperText,
                      helperStyle: _usernameFocus.hasFocus
                          ? context.textTheme.labelLarge
                              ?.copyWith(color: CustomPalette.mediumGrey)
                          : null,
                      counterText: ''),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
