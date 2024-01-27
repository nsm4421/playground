import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/core/enums/colors.enum.dart';
import 'package:my_app/core/enums/route.enum.dart';
import 'package:my_app/presentation/bloc/auth/auth.bloc.dart';
import 'package:my_app/presentation/bloc/auth/auth.event.dart';
import 'package:my_app/presentation/component/text_button.widget.dart';
import 'package:my_app/presentation/view/auth/auth_form.widget.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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

  _handleSignIn() {
    try {
      final isValid = _formKey.currentState!.validate();
      if (!isValid) return;
      context.read<AuthBloc>().add(SignInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text));
    } catch (err) {
      debugPrint(err.toString());
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('error'),
          duration: Duration(seconds: 2), // Adjust the duration as needed
        ));
      }
    }
  }

  _goToSignUpPage() {
    context.push(RoutePath.signUp.path);
  }

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
                  SignInFormWidget(
                      emailTec: _emailController,
                      passwordTec: _passwordController,
                      formKey: _formKey),
                  const SizedBox(height: 30),
                  TextButtonWidget(label: "Login", onTap: _handleSignIn),
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
