part of "sign-up.page.dart";

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _emailTec;
  late TextEditingController _passwordTec;
  late TextEditingController _passwordConfirmTec;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _emailTec = TextEditingController();
    _passwordTec = TextEditingController();
    _passwordConfirmTec = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailTec.dispose();
    _passwordTec.dispose();
    _passwordConfirmTec.dispose();
  }

  String? _handleValidateEmail(String? value) {
    if (value == null) {
      return "Send Email";
    } else {
      const pattern =
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&\'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+\.[a-zA-Z]{2,}$";
      final regExp = RegExp(pattern);
      return regExp.hasMatch(value) ? null : "Not Valid Email Address";
    }
  }

  String? _handleValidatePassword(String? value) {
    if (value == null) {
      return "Send Password";
    } else {
      return value.length >= 6 ? null : "Not Valid Password";
    }
  }

  String? _handleValidatePasswordConfirm(String? value) {
    return _passwordTec.text == _passwordConfirmTec.text
        ? null
        : "Password Is Not Matched";
  }

  Future<void> _handleSubmit() async {
    final ok = _formKey.currentState?.validate() ?? false;
    if (ok) {
      context.read<AuthBloc>().add(SignUpWithEmailAndPasswordEvent(
          email: _emailTec.text.trim(), password: _passwordTec.text.trim()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign UP"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: _handleValidateEmail,
                  controller: _emailTec,
                  decoration: InputDecoration(
                      labelText: "EMAIL",
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.email),
                      prefixIconColor: Theme.of(context).colorScheme.primary),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: _handleValidatePassword,
                  controller: _passwordTec,
                  decoration: InputDecoration(
                      labelText: "PASSWORD",
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.password),
                      prefixIconColor: Theme.of(context).colorScheme.primary),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: _handleValidatePasswordConfirm,
                  controller: _passwordConfirmTec,
                  decoration: InputDecoration(
                      labelText: "PASSWORD CONFIRM",
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.password),
                      prefixIconColor: Theme.of(context).colorScheme.primary),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                          Theme.of(context)
                              .colorScheme
                              .primaryContainer), // 배경 색상 설정
                    ),
                    onPressed: _handleSubmit,
                    child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Text("SUBMIT",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimary)))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
