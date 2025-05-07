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

  bool _isPasswordVisible = false;

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

  String? Function(String?) get _handleValidateUsername =>
      Regex.username.validate;

  String? Function(String?) get _handleValidatePassword =>
      Regex.password.validate;

  void _handleClearUsername() => _usernameController.clear();

  void _switchPasswordVisibility() => setState(() {
        _isPasswordVisible = !_isPasswordVisible;
      });

  void _handleSubmit() {
    _formKey.currentState?.save();
    final ok = _formKey.currentState?.validate();
    if (ok == null || !ok) return;
    context.read<AuthBloc>().add(SignInEvent(
        username: _usernameController.text.trim(),
        password: _passwordController.text.trim()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: const Text("Sign In")),
      body: Column(
        children: [
          const Spacer(
            flex: 1,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: context.colorScheme.primaryContainer.withOpacity(0.5)),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Username",
                          style: context.textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        6.height,
                        TextFormField(
                          controller: _usernameController,
                          maxLength: _maxUsernameLength,
                          validator: _handleValidateUsername,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            prefixIcon: const Icon(Icons.account_box_outlined),
                            suffixIcon: IconButton(
                              onPressed: _handleClearUsername,
                              icon: const Icon(Icons.clear),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Password",
                          style: context.textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        6.height,
                        TextFormField(
                          controller: _passwordController,
                          maxLength: _maxPasswordLength,
                          validator: _handleValidatePassword,
                          obscureText: !_isPasswordVisible,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            prefixIcon: const Icon(Icons.password),
                            suffixIcon: IconButton(
                              onPressed: _switchPasswordVisibility,
                              icon: Icon(_isPasswordVisible
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(
            flex: 2,
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.small(
        onPressed: _handleSubmit,
        child: const Icon(Icons.check),
      ),
    );
  }
}
