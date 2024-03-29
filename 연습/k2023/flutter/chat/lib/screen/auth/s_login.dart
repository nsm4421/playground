import 'package:chat_app/controller/auth_controller.dart';
import 'package:chat_app/screen/widget/w_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _emailTEC;
  late TextEditingController _passwordTEC;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _emailTEC = TextEditingController();
    _passwordTEC = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailTEC.dispose();
    _passwordTEC.dispose();
  }

  _handleLoginWithEmailAndPassword() =>
      ref.read(authControllerProvider).loginWithEmailAndPassword(
            context: context,
            formKey: _formKey,
            emailTEC: _emailTEC,
            passwordTEC: _passwordTEC,
          );

  _handleGoToSignUpPage() =>
      ref.read(authControllerProvider).goToSignUpPage(context);

  _handleSignUpWithGoogle() =>
      ref.read(authControllerProvider).signUpWithGoogle(context);

  Widget _header() {
    return Text(
      "Chat App",
      style: GoogleFonts.lobsterTwo(
        fontSize: 45,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Form _form() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          /// Email
          TextFormField(
              controller: _emailTEC,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Email",
                  suffixIcon: Icon(Icons.email)),
              validator: (v) =>
                  (v == null || v.isEmpty) ? "Press Email" : null),
          const Height(32),

          /// Password
          TextFormField(
              controller: _passwordTEC,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Password",
                suffixIcon: Icon(Icons.key),
              ),
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              validator: (v) =>
                  (v == null || v.isEmpty) ? "Press Password" : null),
        ],
      ),
    );
  }

  _loginBtn() => ElevatedButton(
        onPressed: _handleLoginWithEmailAndPassword,
        child: Text(
          "Login",
          style: GoogleFonts.lobsterTwo(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

  _signUpBtn() => InkWell(
        onTap: _handleGoToSignUpPage,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.email_outlined,
                size: 25,
                color: Colors.teal,
              ),
              const Width(15),
              Text(
                "Sign up with email?",
                style: GoogleFonts.karla(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              )
            ],
          ),
        ),
      );

  _googleSignUpBtn() => InkWell(
        onTap: _handleSignUpWithGoogle,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/google-icon.png",
                height: 25,
                width: 25,
              ),
              const Width(15),
              Text(
                "Sign up with google?",
                style: GoogleFonts.karla(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              )
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _header(),
                  const Height(64),
                  _form(),
                  const Height(32),
                  _loginBtn(),
                  const Height(8),
                  const DefaultDivider(),
                  const Height(8),
                  _signUpBtn(),
                  const Height(8),
                  _googleSignUpBtn(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
