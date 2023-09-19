import 'package:chat_app/controller/auth_controller.dart';
import 'package:chat_app/screen/widget/w_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailTEC;
  late TextEditingController _passwordTEC;
  late TextEditingController _passwordConfirmTEC;

  @override
  void initState() {
    super.initState();
    _emailTEC = TextEditingController();
    _passwordTEC = TextEditingController();
    _passwordConfirmTEC = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailTEC.dispose();
    _passwordTEC.dispose();
    _passwordConfirmTEC.dispose();
  }

  _signUpWithEmailAndPassword() =>
      ref.read(authControllerProvider).signUpWithEmailAndPassword(
            context: context,
            formKey: _formKey,
            emailTEC: _emailTEC,
            passwordTEC: _passwordTEC,
            passwordConfirmTEC: _passwordConfirmTEC,
          );

  AppBar _appBar() {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      leading: InkWell(
        onTap: () {
          context.go('/login');
        },
        child: const Icon(Icons.arrow_back_ios),
      ),
      title: Text(
        "Sign Up",
        style: GoogleFonts.lobsterTwo(
          fontWeight: FontWeight.bold,
          fontSize: 32,
        ),
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Text(
        "Welcome to  chat app",
        style:
            GoogleFonts.lobsterTwo(fontSize: 32, fontWeight: FontWeight.bold),
      ),
    );
  }

  Form _form() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          children: [
            TextFormField(
                controller: _emailTEC,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Email",
                  prefixIcon: Icon(
                    Icons.email,
                  ),
                ),
                validator: (v) =>
                    (v == null || v.isEmpty) ? "Press Email" : null),
            const Height(32),
            TextFormField(
              controller: _passwordTEC,
              obscureText: true,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Password",
                prefixIcon: Icon(
                  Icons.key,
                ),
              ),
              validator: (v) =>
                  (v == null || v.isEmpty) ? "Press Password" : null,
            ),
            const Height(32),
            TextFormField(
              controller: _passwordConfirmTEC,
              obscureText: true,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Password Confirm",
                prefixIcon: Icon(
                  Icons.key,
                ),
              ),
              validator: (v) =>
                  (v != _passwordTEC.text) ? "password is not matched" : null,
            )
          ],
        ),
      ),
    );
  }

  _signUpBtn() => ElevatedButton(
        onPressed: _signUpWithEmailAndPassword,
        child: Text(
          "Sign Up",
          style: GoogleFonts.lobsterTwo(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _appBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _header(),
              const Height(40),
              _form(),
              const Height(30),
              _signUpBtn()
            ],
          ),
        ),
      ),
    );
  }
}
