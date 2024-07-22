part of "sign_in.page.dart";

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _emailTec;
  late TextEditingController _passwordTec;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _emailTec = TextEditingController();
    _passwordTec = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailTec.dispose();
    _passwordTec.dispose();
  }

  _handleSubmit() {
    _formKey.currentState?.save();
    final ok = _formKey.currentState?.validate() ?? false;
    if (ok) {
      context.read<AuthBloc>().add(SignInWithEmailAndPasswordEvent(
          email: _emailTec.text.trim(), password: _passwordTec.text.trim()));
    }
  }

  _handleMoveToSignUpPage() => context.push(RoutePaths.signUp.path);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SIGN IN"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (String? text) =>
                      (text != null && text.isNotEmpty) ? null : "Press Email",
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
                  validator: (String? text) => (text != null && text.isNotEmpty)
                      ? null
                      : "Press Password",
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
                        child: Text("Login",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimary)))),
              ),
              const Padding(
                  padding: EdgeInsets.symmetric(vertical: 3),
                  child: Divider(indent: 10, endIndent: 10, thickness: 0.8)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Text("Want to create account?",
                      style: Theme.of(context).textTheme.labelLarge),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(
                              Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer), // 배경 색상 설정
                        ),
                        onPressed: _handleMoveToSignUpPage,
                        child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: Text("Sign Up",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSecondary)))),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
