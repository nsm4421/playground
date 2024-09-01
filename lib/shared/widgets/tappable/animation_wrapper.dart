part of 'tappable.dart';

class _ButtonAnimationWrapper extends StatelessWidget {
  const _ButtonAnimationWrapper({
    required this.variant,
    required this.child,
    required this.animation,
    this.scaleAlignment,
  });

  final TappableVariant variant;
  final Widget child;
  final Animation<double> animation;
  final Alignment? scaleAlignment;

  @override
  Widget build(BuildContext context) {
    return switch (variant) {
      TappableVariant.faded => FadeTransition(opacity: animation, child: child),
      TappableVariant.scaled => ScaleTransition(
          scale: animation,
          alignment: scaleAlignment!,
          child: child,
        ),
      _ => child,
    };
  }
}
