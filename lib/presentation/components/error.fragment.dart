import 'package:flutter/material.dart';

class ErrorFragment extends StatelessWidget {
  const ErrorFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text("ERROR", style: Theme.of(context).textTheme.displaySmall));
  }
}
