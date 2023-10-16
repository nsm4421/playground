import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  const LoadingContainer(
      {super.key,
      required this.child,
      required this.isLoading,
      this.opacity = 0.2});

  final bool isLoading;
  final Widget child;
  final double opacity;

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          Opacity(
            opacity: isLoading ? opacity : 1.0,
            child: AbsorbPointer(
              absorbing: isLoading,
              child: child,
            ),
          ),
          Opacity(
            opacity: isLoading ? 1.0 : 0,
            child: const Center(child: CircularProgressIndicator()),
          ),
        ],
      );
}
