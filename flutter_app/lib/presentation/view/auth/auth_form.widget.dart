import 'package:flutter/material.dart';

class EmailFieldWidget extends StatelessWidget {
  const EmailFieldWidget(this._tec, {super.key});

  final TextEditingController _tec;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Row(
            children: [
              Text("Email",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.w700)),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    _tec.clear();
                  },
                  icon: const Icon(Icons.clear))
            ],
          ),
          TextFormField(
            validator: (email) {
              if (email == null) return "error";
              if (email.isEmpty) return "press email";
              final emailRegex = RegExp(
                  r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$');
              final isValidEmail = emailRegex.hasMatch(email);
              if (!isValidEmail) return "not valid email";
              return null;
            },
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
                hintText: 'press email',
                prefixIcon: Icon(Icons.mail_outline_outlined),
                border: OutlineInputBorder()),
            controller: _tec,
          ),
        ],
      );
}

class PasswordFieldWidget extends StatefulWidget {
  const PasswordFieldWidget(
      {super.key, required this.tec, this.isConfirm = false, this.validator});

  final TextEditingController tec;
  final bool isConfirm;
  final String? Function(String?)? validator;

  @override
  State<PasswordFieldWidget> createState() => _PasswordFieldWidgetState();
}

class _PasswordFieldWidgetState extends State<PasswordFieldWidget> {
  bool _isVisible = false;

  _switchVisibility() => setState(() {
        _isVisible = !_isVisible;
      });

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Row(
            children: [
              Text(widget.isConfirm ? "Password Confirm" : "Password",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.w700)),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    widget.tec.clear();
                  },
                  icon: const Icon(Icons.clear)),
            ],
          ),
          TextFormField(
            validator: widget.validator,
            keyboardType: TextInputType.visiblePassword,
            obscureText: !_isVisible,
            decoration: InputDecoration(
                hintText: widget.isConfirm
                    ? "press password again"
                    : 'contain digit, at least 8 char',
                prefixIcon: const Icon(Icons.password_outlined),
                suffixIcon: IconButton(
                    onPressed: _switchVisibility,
                    icon: Icon(
                        _isVisible ? Icons.visibility_off : Icons.visibility)),
                border: const OutlineInputBorder()),
            controller: widget.tec,
          ),
        ],
      );
}

class SignInFormWidget extends StatelessWidget {
  const SignInFormWidget(
      {super.key,
      required this.emailTec,
      required this.passwordTec,
      required this.formKey});

  final TextEditingController emailTec;
  final TextEditingController passwordTec;
  final GlobalKey<FormState> formKey;

  String? _passwordValidator(String? password) {
    if (password == null) return "error";
    if (password.isEmpty) return "press password";
    final passwordRegex = RegExp(r'^(?=.*[a-zA-Z])(?=.*\d).{8,}$');
    final isValidPassword = passwordRegex.hasMatch(password);
    if (!isValidPassword) {
      return "not valid password";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) => Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            EmailFieldWidget(emailTec),
            const SizedBox(height: 30),
            PasswordFieldWidget(
                tec: passwordTec,
                isConfirm: false,
                validator: _passwordValidator),
          ],
        ),
      );
}

class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget(
      {super.key,
      required this.emailTec,
      required this.passwordTec,
      required this.passwordConfirmTec,
      required this.formKey});

  final TextEditingController emailTec;
  final TextEditingController passwordTec;
  final TextEditingController passwordConfirmTec;
  final GlobalKey<FormState> formKey;

  String? _passwordValidator(String? password) {
    if (password == null) return "error";
    if (password.isEmpty) return "press password";
    final passwordRegex = RegExp(r'^(?=.*[a-zA-Z])(?=.*\d).{8,}$');
    final isValidPassword = passwordRegex.hasMatch(password);
    if (!isValidPassword) {
      return "not valid password";
    }
    return null;
  }

  String? _passwordConfirmValidator(String? passwordConfirm) {
    if (passwordConfirm == null) return "error";
    return passwordTec.text == passwordConfirm
        ? null
        : 'passwords are not matched';
  }

  @override
  Widget build(BuildContext context) => Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            EmailFieldWidget(emailTec),
            const SizedBox(height: 30),
            PasswordFieldWidget(
                tec: passwordTec,
                isConfirm: false,
                validator: _passwordValidator),
            const SizedBox(height: 30),
            PasswordFieldWidget(
                tec: passwordConfirmTec,
                isConfirm: true,
                validator: _passwordConfirmValidator),
          ],
        ),
      );
}
