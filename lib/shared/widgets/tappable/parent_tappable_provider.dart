part of 'tappable.dart';

abstract class _ParentTappableState {
  void markChildTappablePressed(
    _ParentTappableState childState,
    bool value,
  );
}

class _ParentTappableProvider extends InheritedWidget {
  const _ParentTappableProvider({
    required this.state,
    required super.child,
  });

  final _ParentTappableState state;

  @override
  bool updateShouldNotify(_ParentTappableProvider oldWidget) =>
      state != oldWidget.state;

  static _ParentTappableState? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_ParentTappableProvider>()
        ?.state;
  }
}
