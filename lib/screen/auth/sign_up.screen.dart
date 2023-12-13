import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/screen/auth/login.screen.dart';

import '../../configurations.dart';
import '../../core/response/response.dart';
import '../../repository/auth/auth.repository.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController _emailTec;
  late TextEditingController _passwordTec;
  late TextEditingController _passwordConfirmTec;
  late TextEditingController _nicknameTec;

  bool _isPasswordVisible = false;
  bool _isPasswordConfirmVisible = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _emailTec = TextEditingController();
    _passwordTec = TextEditingController();
    _passwordConfirmTec = TextEditingController();
    _nicknameTec = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailTec.dispose();
    _passwordTec.dispose();
    _passwordConfirmTec.dispose();
    _nicknameTec.dispose();
  }

  _handlePasswordVisible() => setState(() {
        _isPasswordVisible = !_isPasswordVisible;
      });

  _handlePasswordConfirmVisible() => setState(() {
        _isPasswordConfirmVisible = !_isPasswordConfirmVisible;
      });

  _handleSignUp() async {
    try {
      // check user input
      final email = _emailTec.text.trim();
      final password = _passwordTec.text.trim();
      final passwordConfirm = _passwordConfirmTec.text.trim();
      final nickname = _nicknameTec.text.trim();
      if (email.isEmpty || password.isEmpty || nickname.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('email,password or nickname are not given'),
          duration: Duration(seconds: 2),
        ));
        return;
      }
      if (password != passwordConfirm) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('passwords are not same'),
          duration: Duration(seconds: 2),
        ));
        return;
      }

      // sign up
      _isLoading = true;
      final signUpResponse = await getIt<AuthRepository>()
          .createUserWithEmailAndPassword(email, password);

      // sign up fail
      if (signUpResponse.status == Status.error) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('sign up failed'),
            duration: Duration(seconds: 2),
          ));
        }
        return;
      }

      // save user info in DB
      final uid = signUpResponse.data?.user?.uid;
      await getIt<AuthRepository>()
          .saveUser(uid: uid!, email: email, nickname: nickname);

      // go to login page
      if (context.mounted) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const LoginScreen()));
      }
    } catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(err.toString()),
        duration: const Duration(seconds: 2),
      ));
    } finally {
      _isLoading = false;
    }
  }

  _handleGoToPreviousPage() => Navigator.pop(context);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height / 5),
                  Text("Sign Up",
                      style: GoogleFonts.lobsterTwo(
                          fontWeight: FontWeight.bold, fontSize: 40)),
                  const SizedBox(height: 10),
                  const Text("Welcome to my app"),
                  const SizedBox(height: 50),
                  _SignUpTextField(
                    tec: _emailTec,
                    hintText: 'Email',
                    prefixIcon: const Icon(Icons.email),
                  ),
                  const SizedBox(height: 20),
                  _SignUpTextField(
                    tec: _passwordTec,
                    hintText: 'Password',
                    prefixIcon: const Icon(Icons.key),
                    isObscure: !_isPasswordVisible,
                    suffixIcon: IconButton(
                      onPressed: _handlePasswordVisible,
                      icon: _isPasswordVisible
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _SignUpTextField(
                    tec: _passwordConfirmTec,
                    hintText: 'Password Confirm',
                    prefixIcon: const Icon(Icons.key),
                    isObscure: !_isPasswordConfirmVisible,
                    suffixIcon: IconButton(
                      onPressed: _handlePasswordConfirmVisible,
                      icon: _isPasswordConfirmVisible
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _SignUpTextField(
                    tec: _nicknameTec,
                    hintText: 'Nickname',
                    prefixIcon: const Icon(Icons.abc_outlined),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                      onPressed: _isLoading ? null : _handleSignUp,
                      child: Text(
                        "Sign Up",
                        style: GoogleFonts.karla(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )),
                  const SizedBox(height: 30),
                  const Divider(endIndent: 30, thickness: 0.8),
                  const SizedBox(height: 10),
                  InkWell(
                      onTap: _handleGoToPreviousPage,
                      child: Text(
                        "Back To Login Page?",
                        style: GoogleFonts.karla(
                            color: Theme.of(context).colorScheme.tertiary,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ))
                ],
              ),
            ),
          ),
        ),
      );
}

class _SignUpTextField extends StatelessWidget {
  const _SignUpTextField(
      {super.key,
      required this.tec,
      this.isObscure = false,
      this.hintText,
      this.prefixIcon,
      this.suffixIcon});

  final TextEditingController tec;
  final String? hintText;
  final Icon? prefixIcon;
  final bool isObscure;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) => TextFormField(
        controller: tec,
        obscureText: isObscure,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(8),
          hintText: hintText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      );
}
