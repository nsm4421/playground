import 'package:flutter/material.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField(this._textEditingController,
      {super.key, this.maxLength = 30});

  final TextEditingController _textEditingController;
  final int? maxLength;

  _handleClear() => _textEditingController.clear();

  @override
  Widget build(BuildContext context) => TextField(
        maxLength: maxLength,
        style: const TextStyle(decorationThickness: 0, letterSpacing: 2),
        decoration: InputDecoration(
          hintText: "이메일을 입력해주세요",
          prefixIcon: const Icon(Icons.email),
          suffixIcon: IconButton(
              onPressed: _handleClear, icon: const Icon(Icons.clear)),
          border: const OutlineInputBorder(),
        ),
        controller: _textEditingController,
      );
}

class PasswordTextField extends StatefulWidget {
  const PasswordTextField(this._textEditingController,
      {super.key, this.hintText, this.maxLength = 30});

  final TextEditingController _textEditingController;
  final String? hintText;
  final int? maxLength;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _isVisible = false;

  _handleVisible() => setState(() {
        _isVisible = !_isVisible;
      });

  @override
  Widget build(BuildContext context) => TextField(
        maxLength: widget.maxLength,
        obscureText: !_isVisible,
        style: const TextStyle(decorationThickness: 0, letterSpacing: 2),
        decoration: InputDecoration(
          hintText: widget.hintText,
          prefixIcon: const Icon(Icons.key),
          suffixIcon: IconButton(
              onPressed: _handleVisible,
              icon: _isVisible
                  ? const Icon(Icons.visibility_off)
                  : const Icon(Icons.visibility)),
          border: const OutlineInputBorder(),
        ),
        controller: widget._textEditingController,
      );
}

class NicknameTextField extends StatelessWidget {
  const NicknameTextField(this._textEditingController,
      {super.key, this.maxLength = 20});

  final TextEditingController _textEditingController;
  final int? maxLength;

  _handleClear() => _textEditingController.clear();

  @override
  Widget build(BuildContext context) => TextField(
        maxLength: maxLength,
        style: const TextStyle(decorationThickness: 0, letterSpacing: 2),
        decoration: InputDecoration(
          hintText: "닉네임을 입력해주세요",
          prefixIcon: const Icon(Icons.account_circle),
          suffixIcon: IconButton(
              onPressed: _handleClear, icon: const Icon(Icons.clear)),
          border: const OutlineInputBorder(),
        ),
        controller: _textEditingController,
      );
}
