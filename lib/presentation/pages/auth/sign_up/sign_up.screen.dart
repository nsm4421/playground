part of '../../export.pages.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  static const _maxEmailLength = 30;
  static const _maxPasswordLength = 30;
  static const _maxUsernameLength = 30;
  static const _maxNicknameLength = 30;

  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _passwordConfirmController;
  late TextEditingController _usernameController;
  late TextEditingController _nicknameController;
  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _passwordConfirmController = TextEditingController();
    _usernameController = TextEditingController();
    _nicknameController = TextEditingController();

    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    _usernameController.dispose();
    _nicknameController.dispose();
  }

  String? _handleValidateEmail(String? text) {
    if (text == null || text.isEmpty) {
      return "Email is not given";
    }
    // TODO : 이메일 검사
    return null;
  }

  String? _handleValidatePassword(String? text) {
    if (text == null || text.isEmpty) {
      return "Password is not given";
    }
    // TODO : 패스워드 검사
    return null;
  }

  String? _handleValidatePasswordConfirm(String? text) {
    if (text == null || text.isEmpty) {
      return "Password confirm is not given";
    } else if (text != _passwordController.text.trim()) {
      return "Password not match";
    }
    return null;
  }

  String? _handleValidateUsername(String? text) {
    if (text == null || text.isEmpty) {
      return "Username is not given";
    }
    // TODO : 유저명 검사
    return null;
  }

  String? _handleValidateNickname(String? text) {
    if (text == null || text.isEmpty) {
      return "Nickname is not given";
    }
    // TODO : 유저명 검사
    return null;
  }

  _handleSignUp() async {
    _formKey.currentState?.save();
    final ok = _formKey.currentState?.validate();
    if (ok == null || !ok) {
      log('input is not valid');
      return;
    }
    context.read<AuthBloc>().add(SignUpEvent(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        username: _usernameController.text.trim(),
        nickname: _nicknameController.text.trim()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Sign Up Page"),
      ),
      body: Column(
        children: [
          Spacer(flex: 1),
          Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: TextFormField(
                    controller: _emailController,
                    maxLength: _maxEmailLength,
                    validator: _handleValidateEmail,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Email(~$_maxEmailLength character)',
                        prefixIcon: Icon(Icons.email_outlined),
                        counterText: ''),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: TextFormField(
                    controller: _nicknameController,
                    maxLength: _maxNicknameLength,
                    validator: _handleValidateNickname,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Nickname(~$_maxNicknameLength character)',
                        prefixIcon: Icon(Icons.abc),
                        counterText: ''),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: TextFormField(
                    controller: _passwordController,
                    maxLength: _maxPasswordLength,
                    validator: _handleValidatePassword,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Password(~$_maxPasswordLength character)',
                        prefixIcon: Icon(Icons.key_outlined),
                        counterText: ''),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: TextFormField(
                    controller: _passwordConfirmController,
                    maxLength: _maxPasswordLength,
                    validator: _handleValidatePasswordConfirm,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Password Confirm',
                        prefixIcon: Icon(Icons.key_outlined),
                        counterText: ''),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: TextFormField(
                    controller: _usernameController,
                    maxLength: _maxUsernameLength,
                    validator: _handleValidateUsername,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Username(~$_maxEmailLength character)',
                        prefixIcon: Icon(Icons.account_box_outlined),
                        counterText: ''),
                  ),
                ),
              ],
            ),
          ),
          25.height,
          ElevatedButton(
              onPressed: _handleSignUp, child: const Text("SUBMIT")),
          const Spacer(flex: 3),
        ],
      ),
    );
  }
}
