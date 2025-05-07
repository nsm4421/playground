part of '../../export.pages.dart';

class SignUpFormFragment extends StatefulWidget {
  const SignUpFormFragment({super.key});

  @override
  State<SignUpFormFragment> createState() => _SignUpFormFragmentState();
}

class _SignUpFormFragmentState extends State<SignUpFormFragment> {
  static const _maxEmailLength = 30;
  static const _maxPasswordLength = 30;
  static const _maxUsernameLength = 30;
  static const _maxNicknameLength = 30;

  late FocusNode _emailFocus;
  late FocusNode _passwordFocus;
  late FocusNode _usernameFocus;
  late FocusNode _nicknameFocus;

  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _passwordConfirmController;
  late TextEditingController _usernameController;
  late TextEditingController _nicknameController;

  bool _isPasswordVisible = false;
  bool _isPasswordConfirmVisible = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _passwordConfirmController = TextEditingController();
    _usernameController = TextEditingController();
    _nicknameController = TextEditingController();
    _emailFocus = FocusNode()..addListener(_handleOnFocusLeave);
    _passwordFocus = FocusNode()..addListener(_handleOnFocusLeave);
    _usernameFocus = FocusNode()..addListener(_handleOnFocusLeave);
    _nicknameFocus = FocusNode()..addListener(_handleOnFocusLeave);
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    _usernameController.dispose();
    _nicknameController.dispose();
    _emailFocus
      ..removeListener(_handleOnFocusLeave)
      ..dispose();
    _passwordFocus
      ..removeListener(_handleOnFocusLeave)
      ..dispose();
    _usernameFocus
      ..removeListener(_handleOnFocusLeave)
      ..dispose();
    _nicknameFocus
      ..removeListener(_handleOnFocusLeave)
      ..dispose();
  }

  String? Function(String?) get _handleValidateEmail => Regex.email.validate;

  String? Function(String?) get _handleValidatePassword =>
      Regex.password.validate;

  String? Function(String?) get _handleValidateUsername =>
      Regex.username.validate;

  String? Function(String?) get _handleValidateNickname =>
      Regex.nickname.validate;

  String? _handleValidatePasswordConfirm(String? text) {
    if (text == null || text.isEmpty) {
      return "Password confirm is not given";
    } else if (text != _passwordController.text.trim()) {
      return "Password not match";
    }
    return null;
  }

  void _handleClearEmail() => _emailController.clear();

  void _handleClearUsername() => _usernameController.clear();

  void _handleClearNickname() => _nicknameController.clear();

  void _switchPasswordVisibility() => setState(() {
        _isPasswordVisible = !_isPasswordVisible;
      });

  void _switchPasswordConfirmVisibility() => setState(() {
        _isPasswordConfirmVisible = !_isPasswordConfirmVisible;
      });

  _handleOnFocusLeave() {
    if (!_emailFocus.hasFocus) {
      context
          .read<SignUpCubit>()
          .update(email: _emailController.text.trim());
    }
    if (!_passwordFocus.hasFocus) {
      context.read<SignUpCubit>().update(
            password: _passwordController.text.trim(),
          );
    }
    if (!_usernameFocus.hasFocus) {
      context
          .read<SignUpCubit>()
          .update(username: _usernameController.text.trim());
    }
    if (!_nicknameFocus.hasFocus) {
      context
          .read<SignUpCubit>()
          .update(nickname: _nicknameController.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<SignUpCubit>().formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: TextFormField(
              focusNode: _emailFocus,
              controller: _emailController,
              maxLength: _maxEmailLength,
              validator: _handleValidateEmail,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.email_outlined),
                  suffixIcon: IconButton(
                      onPressed: _handleClearEmail,
                      icon: const Icon(Icons.clear)),
                  hintText: 'karma@naver.com',
                  helperText: 'your email address'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: TextFormField(
              focusNode: _usernameFocus,
              controller: _usernameController,
              maxLength: _maxUsernameLength,
              validator: _handleValidateUsername,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.abc),
                  suffixIcon: IconButton(
                      onPressed: _handleClearUsername,
                      icon: const Icon(Icons.clear)),
                  hintText: 'karma1221',
                  helperText: 'username for login'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: TextFormField(
              focusNode: _nicknameFocus,
              controller: _nicknameController,
              maxLength: _maxNicknameLength,
              validator: _handleValidateNickname,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.account_box_outlined),
                  suffixIcon: IconButton(
                      onPressed: _handleClearNickname,
                      icon: const Icon(Icons.clear)),
                  hintText: 'karma',
                  helperText: 'Nickname'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: TextFormField(
              focusNode: _passwordFocus,
              controller: _passwordController,
              maxLength: _maxPasswordLength,
              validator: _handleValidatePassword,
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.key_outlined),
                  suffixIcon: IconButton(
                      onPressed: _switchPasswordVisibility,
                      icon: Icon(_isPasswordVisible
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined)),
                  hintText: 'Password',
                  helperText:
                      'Contain special symbol and at least 8 characters'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: TextFormField(
              controller: _passwordConfirmController,
              maxLength: _maxPasswordLength,
              validator: _handleValidatePasswordConfirm,
              obscureText: !_isPasswordConfirmVisible,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Password Confirm',
                helperText: 'press password again',
                prefixIcon: const Icon(Icons.key_outlined),
                suffixIcon: IconButton(
                    onPressed: _switchPasswordConfirmVisibility,
                    icon: Icon(_isPasswordConfirmVisible
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
