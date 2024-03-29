import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/core/enums/colors.enum.dart';
import 'package:my_app/presentation/bloc/auth/auth.bloc.dart';
import 'package:my_app/presentation/bloc/auth/auth.event.dart';
import 'package:my_app/presentation/component/text_button.widget.dart';
import 'package:my_app/presentation/view/auth/auth_form.widget.dart';

import '../../../core/enums/status.enum.dart';
import '../../bloc/auth/auth.state.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocListener<AuthBloc, AuthState>(
      listener: (ctx, state) {
        if (state.status == Status.success && ctx.mounted) {
          ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
              content: Text('sign up success~!'),
              duration: Duration(seconds: 2)));
          context.pop();
          return;
        }

        if (state.status == Status.error && ctx.mounted) {
          ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
              content:
                  Text('Fail To Sign Up...', overflow: TextOverflow.ellipsis),
              duration: Duration(seconds: 2)));
          return;
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
          builder: (_, state) => state.status == Status.loading
              ? const Center(child: CircularProgressIndicator())
              : const _SignUpScreenView()));
}

class _SignUpScreenView extends StatefulWidget {
  const _SignUpScreenView({super.key});

  @override
  State<_SignUpScreenView> createState() => _SignUpScreenViewState();
}

class _SignUpScreenViewState extends State<_SignUpScreenView> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _passwordConfirmController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _passwordConfirmController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
  }

  _handleSignUp() {
    try {
      // validate
      final isValid = _formKey.currentState!.validate();
      if (!isValid) return;

      // sign up
      context.read<AuthBloc>().add(SignUpWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text));
    } catch (err) {
      // on error, show snackbar
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('error'),
            duration: Duration(seconds: 2), // Adjust the duration as needed
          ),
        );
      }
      debugPrint(err.toString());
    }
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          appBar: AppBar(elevation: 0),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  SignUpFormWidget(
                      emailTec: _emailController,
                      passwordTec: _passwordController,
                      passwordConfirmTec: _passwordConfirmController,
                      formKey: _formKey),
                  const SizedBox(height: 30),
                  TextButtonWidget(
                      label: "Sign Up",
                      onTap: _handleSignUp,
                      colorScheme: CustomColorScheme.secondary),
                ],
              ),
            ),
          ),
        ),
      );
}
