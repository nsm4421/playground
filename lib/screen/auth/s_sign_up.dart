import 'package:chat_app/screen/widget/w_box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  Future<void> _handleSignUp() async {
    try {
      if (!_formKey.currentState!.validate()) {
        _showSnackBar('check input again');
        return;
      }
      _formKey.currentState!.save();

      /// sign up & save in fire store
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          )
          .then((credential) =>
              FirebaseFirestore.instance.collection('users').add({
                "uid": credential.user?.uid ?? '',
                "email": credential.user?.email ?? "",
              }));

      /// on success, go to login screen
      if (context.mounted) {
        _showSnackBar('success');
        context.go('/login');
        return;
      }
    }

    /// on error - show error message
    on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "weak-password":
          _showSnackBar('password is too weak...');
          return;
        case "email-already-in-use":
          _showSnackBar('email is already in use...');
          return;
        default:
          _showSnackBar('firebase auth error...');
          return;
      }
    } catch (e) {
      _showSnackBar('unknown error...');
      return;
    }
  }

  void _showSnackBar(String message) => ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(message)));

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

  _signUpBtn() => ElevatedButton(
        onPressed: _handleSignUp,
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
