import 'package:flutter/material.dart';

class Height extends StatelessWidget {
  final double size;

  const Height(this.size, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
    );
  }
}

class Width extends StatelessWidget {
  final double size;

  const Width(this.size, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
    );
  }
}

class DefaultDivider extends StatelessWidget {
  const DefaultDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
        color: Colors.blueGrey,
        thickness: 0.5,
        indent: 50,
        endIndent: 50,
        height: 50);
  }
}

class ExpandedSizedBox extends StatelessWidget {
  const ExpandedSizedBox({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(child: SizedBox());
  }
}
