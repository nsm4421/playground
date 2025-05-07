part of 'index.dart';

class SignInFormFragment extends StatefulWidget {
  const SignInFormFragment({super.key});

  @override
  State<SignInFormFragment> createState() => _SignInFormFragmentState();
}

class _SignInFormFragmentState extends State<SignInFormFragment> {
  // 이메일
  static const _emailMaxLength = 30;
  final _emailRegex =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  late TextEditingController _emailController;
  late FocusNode _emailFocus;

  // 비밀번호
  static const _passwordMaxLength = 30;
  late TextEditingController _passwordController;
  late FocusNode _passwordFocus;
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _emailController =
        TextEditingController(text: context.read<SignInCubit>().state.email);
    _passwordController =
        TextEditingController(text: context.read<SignInCubit>().state.password);
    _emailFocus = FocusNode(debugLabel: 'sign-in-email-text-field')
      ..addListener(_handleEmailFocus);
    _passwordFocus = FocusNode(debugLabel: 'sign-in-password-text-field')
      ..addListener(_handlePasswordFocus);
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus
      ..removeListener(_handleEmailFocus)
      ..dispose();
    _passwordFocus
      ..removeListener(_handlePasswordFocus)
      ..dispose();
  }

  _handlePasswordVisible() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  _handleEmailFocus() {
    setState(() {});
    if (!_emailFocus.hasFocus) {
      context.read<SignInCubit>().edit(email: _emailController.text.trim());
    }
  }

  _handlePasswordFocus() {
    setState(() {});
    if (!_passwordFocus.hasFocus) {
      context
          .read<SignInCubit>()
          .edit(password: _passwordController.text.trim());
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
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<SignInCubit>().formKey,
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
                  labelText: 'Email',
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
                    onPressed: _handlePasswordVisible,
                    icon: _isPasswordVisible
                        ? Icon(
                            Icons.visibility_off_outlined,
                            color: _passwordFocus.hasFocus
                                ? context.colorScheme.primary.withOpacity(0.5)
                                : null,
                          )
                        : Icon(
                            Icons.visibility_outlined,
                            color: _passwordFocus.hasFocus
                                ? context.colorScheme.primary.withOpacity(0.5)
                                : null,
                          ),
                  ),
                  labelText: 'Password',
                  counterText: ''),
            ),
          ),
        ],
      ),
    );
  }
}
