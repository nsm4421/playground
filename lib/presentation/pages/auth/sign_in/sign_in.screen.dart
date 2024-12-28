part of '../../export.pages.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  static const _maxUsernameLength = 50;
  static const _maxPasswordLength = 50;

  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
  }

  String? _handleValidateUsername(String? text) {
    if (text == null || text.isEmpty) {
      return "Username is not given";
    } else if (text.length > _maxUsernameLength) {
      return "Too long username";
    }
    // TODO : 유저명 검사
    return null;
  }

  String? _handleValidatePassword(String? text) {
    if (text == null || text.isEmpty) {
      return "Password is not given";
    } else if (text.length > _maxPasswordLength) {
      return "Too long username";
    }
    // TODO : 패스워드 검사
    return null;
  }

  _handleSignIn() async {
    _formKey.currentState?.save();
    final ok = _formKey.currentState?.validate();
    if (ok == null || !ok) {
      log('input is not valid');
      return;
    }
    context.read<AuthBloc>().add(SignInEvent(
        username: _usernameController.text.trim(),
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
                    controller: _usernameController,
                    maxLength: _maxUsernameLength,
                    validator: _handleValidateUsername,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Username(~$_maxUsernameLength character)',
                        prefixIcon: Icon(Icons.account_box_outlined),
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
