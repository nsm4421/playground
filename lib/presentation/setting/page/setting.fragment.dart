import 'package:flutter/material.dart';

class SettingFragment extends StatelessWidget {
  const SettingFragment({super.key});

  @override
  Widget build(BuildContext context) => Text(
        "Setting",
        style: Theme.of(context).textTheme.displayLarge,
      );
}
