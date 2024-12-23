part of '../../export.pages.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  static const _maxEmailLength = 30;
  static const _maxPasswordLength = 30;

  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
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

  _handleSignIn() async {
    final ok = _formKey.currentState?.validate();
    if (ok == null || !ok) {
      log('input is not valid');
      return;
    }
    context.read<AuthBloc>().add(SignInEvent(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign In")),
      body: Column(
        children: [
          const Spacer(flex: 1),
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
              ],
            ),
          ),
          25.height,
          ElevatedButton(onPressed: _handleSignIn, child: const Text("SUBMIT")),
          const Spacer(flex: 3),
        ],
      ),
    );
  }
}
