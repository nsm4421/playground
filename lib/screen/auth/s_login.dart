import 'package:chat_app/screen/widget/w_box.dart';
import 'package:chat_app/screen/widget/w_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

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
              controller: _emailController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Email",
                  suffixIcon: Icon(Icons.email)),
              validator: (v) =>
                  (v == null || v.isEmpty) ? "Press Email" : null),
          const Height(32),

          /// Password
          TextFormField(
              controller: _passwordController,
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
        onPressed: () {},
        child: Text(
          "Login",
          style: GoogleFonts.lobsterTwo(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

  _signUpBtn() {
    return ButtonWithText(
      label: "Make Account?",
      callback: () {},
      fontSize: 18,
      textColor: Colors.blue,
      bgColor: Colors.white,
    );
  }

  _googleSignUpBtn() {
    return Row(
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
    );
  }

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
                  const DefaultDivider(),
                  _signUpBtn(),
                  const Height(16),
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
