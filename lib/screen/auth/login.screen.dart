import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/screen/auth/sign_up.screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailTec;
  late TextEditingController _passwordTec;

  @override
  void initState() {
    super.initState();
    _emailTec = TextEditingController();
    _passwordTec = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailTec.dispose();
    _passwordTec.dispose();
  }

  // TODO : 이벤트 기능 구현
  _handleGoToFindPasswordPage() {}

  _handleClickLogin() {}

  _handleGoToSignUpPage() => Navigator.push(
      context,
      MaterialPageRoute(
          builder: (BuildContext context) => const SignUpScreen()));

  @override
  Widget build(BuildContext context) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height / 5),
                Text("Karma",
                    style: GoogleFonts.lobsterTwo(
                        fontWeight: FontWeight.bold, fontSize: 50)),
                const SizedBox(height: 50),
                _LoginTextField(
                  tec: _emailTec,
                  hintText: 'Email',
                  prefixIcon: const Icon(Icons.email),
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _LoginTextField(
                      tec: _passwordTec,
                      hintText: 'Password',
                      prefixIcon: const Icon(Icons.key),
                    ),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: _handleGoToFindPasswordPage,
                      child: Text(
                        "Forgot password?",
                        style: GoogleFonts.karla(
                            color: Theme.of(context).colorScheme.tertiary,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: _handleClickLogin,
                    child: Text(
                      "Login",
                      style: GoogleFonts.karla(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    )),
                const SizedBox(height: 50),
                const Spacer(),
                const Divider(endIndent: 30, thickness: 0.8),
                const SizedBox(height: 10),
                InkWell(
                    onTap: _handleGoToSignUpPage,
                    child: Text(
                      "Want to make account?",
                      style: GoogleFonts.karla(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ))
              ],
            ),
          ),
        ),
      );
}

class _LoginTextField extends StatelessWidget {
  const _LoginTextField(
      {super.key, required this.tec, this.hintText, this.prefixIcon});

  final TextEditingController tec;
  final String? hintText;
  final Icon? prefixIcon;

  @override
  Widget build(BuildContext context) => TextFormField(
        controller: tec,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(8),
          hintText: hintText,
          prefixIcon: prefixIcon,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      );
}
