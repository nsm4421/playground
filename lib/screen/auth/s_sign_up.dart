import 'package:chat_app/screen/widget/w_box.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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

  AppBar _appBar() {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      leading: InkWell(
        onTap: () {context.go('/login');},
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
                controller: _emailController,
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
              controller: _passwordController,
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
            )
          ],
        ),
      ),
    );
  }

  _signUpBtn() =>ElevatedButton(
    onPressed: () {},
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
