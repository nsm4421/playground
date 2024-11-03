import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomRouteUtil<T> {
  Page<T> Function(BuildContext, GoRouterState) pageBuilder(Widget child) =>
      (context, state) {
        return CustomTransitionPage(
            child: child,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(0.0, 1.0);
              const end = Offset.zero;
              const curve = Curves.easeInOut;
              final tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              final offsetAnimation = animation.drive(tween);
              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            });
      };
}
