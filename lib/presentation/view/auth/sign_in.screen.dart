import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/core/enums/colors.enum.dart';
import 'package:my_app/core/enums/route.enum.dart';
import 'package:my_app/presentation/component/text_button.widget.dart';
import 'package:my_app/presentation/view/auth/auth_form.widget.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  static const int _maxLength = 30;

  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  // TODO  : auth
  _handleSignIn() {}

  _goToSignUpPage() {
    context.push(RoutePath.signUp.path);
  }

  _switchVisible() => setState(() {
        _isPasswordVisible = !_isPasswordVisible;
      });

  _clearEmail() => _emailController.clear();

  _clearPassword() => _passwordController.clear();

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          appBar: AppBar(
              title: Text("Sign In",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary)),
              elevation: 0),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  EmailFieldWidget(_emailController),
                  const SizedBox(height: 30),
                  PasswordFieldWidget(tec: _passwordController),
                  const SizedBox(height: 30),
                  TextButtonWidget(label: "Sign In", onTap: _handleSignIn),
                  const SizedBox(height: 20),
                  TextButtonWidget(
                      label: "Sign Up",
                      onTap: _goToSignUpPage,
                      colorScheme: CustomColorScheme.secondary),
                ],
              ),
            ),
          ),
        ),
      );
}
