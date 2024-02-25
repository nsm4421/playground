import 'package:flutter/material.dart';

class HomeFragment extends StatelessWidget {
  const HomeFragment({super.key});

  @override
  Widget build(BuildContext context) => Text(
    "Home",
    style: Theme.of(context).textTheme.displayLarge,
  );
}
