import 'package:flutter/material.dart';

class LoadingFragment extends StatelessWidget {
  const LoadingFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
