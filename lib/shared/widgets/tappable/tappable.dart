import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../constant/constant.dart';

part 'animation_wrapper.dart';
part 'parent_tappable_provider.dart';
part 'throttler.dart';

class Tappable extends StatelessWidget {
  const Tappable({
    required this.child,
    super.key,
    this.onTap,
    this.onDoubleTap,
    this.borderRadius,
    this.backgroundColor,
    this.throttle = false,
    this.throttleDuration,
    this.padding,
    this.onTapUp,
    this.onTapDown,
    this.onLongPress,
    this.onLongPressMoveUpdate,
    this.onLongPressStart,
    this.onLongPressEnd,
    this.scaleStrength,
    this.fadeStrength,
    this.scaleAlignment,
    this.boxShadow,
    this.enableFeedback = true,
  }) : _variant = TappableVariant.normal;

  const Tappable.raw({
    required this.child,
    required TappableVariant variant,
    super.key,
    this.onTap,
    this.onDoubleTap,
    this.borderRadius,
    this.backgroundColor,
    this.throttle = false,
    this.throttleDuration,
    this.padding,
    this.onTapUp,
    this.onTapDown,
    this.onLongPress,
    this.onLongPressMoveUpdate,
    this.onLongPressStart,
    this.onLongPressEnd,
    this.scaleStrength = ScaleStrength.sm,
    this.fadeStrength = FadeStrength.md,
    this.scaleAlignment = Alignment.center,
    this.boxShadow,
    this.enableFeedback = true,
  }) : _variant = variant;

  const Tappable.faded({
    required this.child,
    super.key,
    this.onTap,
    this.onDoubleTap,
    this.borderRadius,
    this.backgroundColor,
    this.fadeStrength = FadeStrength.md,
    this.throttle = false,
    this.throttleDuration,
    this.padding,
    this.onTapUp,
    this.onTapDown,
    this.onLongPress,
    this.onLongPressMoveUpdate,
    this.onLongPressStart,
    this.onLongPressEnd,
    this.boxShadow,
    this.enableFeedback = true,
  })  : _variant = TappableVariant.faded,
        scaleAlignment = null,
        scaleStrength = null;

  const Tappable.scaled({
    required this.child,
    super.key,
    this.onTap,
    this.onDoubleTap,
    this.borderRadius,
    this.backgroundColor,
    this.throttle = false,
    this.throttleDuration,
    this.scaleStrength = ScaleStrength.sm,
    this.scaleAlignment = Alignment.center,
    this.padding,
    this.onTapUp,
    this.onTapDown,
    this.onLongPress,
    this.onLongPressMoveUpdate,
    this.onLongPressStart,
    this.onLongPressEnd,
    this.boxShadow,
    this.enableFeedback = true,
  })  : _variant = TappableVariant.scaled,
        fadeStrength = null;

  final TappableVariant _variant;

  final BorderRadiusGeometry? borderRadius;

  final bool enableFeedback;

  final GestureTapCallback? onTap;

  final GestureDoubleTapCallback? onDoubleTap;

  final GestureTapDownCallback? onTapDown;

  final GestureTapUpCallback? onTapUp;

  final Color? backgroundColor;

  final Widget child;

  final EdgeInsetsGeometry? padding;

  final bool throttle;

  final Duration? throttleDuration;

  final GestureLongPressCallback? onLongPress;

  final GestureLongPressMoveUpdateCallback? onLongPressMoveUpdate;

  final GestureLongPressStartCallback? onLongPressStart;

  final GestureLongPressEndCallback? onLongPressEnd;

  final List<BoxShadow>? boxShadow;

  final ScaleStrength? scaleStrength;

  final FadeStrength? fadeStrength;

  final Alignment? scaleAlignment;

  @override
  Widget build(BuildContext context) {
    final parentState = _ParentTappableProvider.maybeOf(context);
    return _TappableStateWidget(
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      onTapUp: onTapUp,
      onTapDown: onTapDown,
      borderRadius: borderRadius,
      backgroundColor: backgroundColor,
      enableFeedback: enableFeedback,
      variant: _variant,
      padding: padding,
      fadeStrength: fadeStrength,
      onLongPress: onLongPress,
      onLongPressMoveUpdate: onLongPressMoveUpdate,
      onLongPressStart: onLongPressStart,
      onLongPressEnd: onLongPressEnd,
      boxShadow: boxShadow,
      scaleAlignment: scaleAlignment,
      scaleStrength: scaleStrength,
      throttle: throttle,
      throttleDuration: throttleDuration,
      parentState: parentState,
      child: child,
    );
  }
}

class _TappableStateWidget extends StatefulWidget {
  const _TappableStateWidget({
    required this.child,
    required this.variant,
    required this.enableFeedback,
    this.onTap,
    this.onDoubleTap,
    this.borderRadius,
    this.backgroundColor,
    this.throttle = false,
    this.throttleDuration,
    this.padding,
    this.onTapUp,
    this.onTapDown,
    this.parentState,
    this.onLongPress,
    this.onLongPressMoveUpdate,
    this.onLongPressStart,
    this.onLongPressEnd,
    this.boxShadow,
    this.scaleStrength,
    this.fadeStrength,
    this.scaleAlignment,
  });

  final TappableVariant variant;
  final BorderRadiusGeometry? borderRadius;
  final bool enableFeedback;
  final GestureTapCallback? onTap;
  final GestureDoubleTapCallback? onDoubleTap;
  final GestureTapDownCallback? onTapDown;
  final GestureTapUpCallback? onTapUp;
  final Color? backgroundColor;
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final bool throttle;
  final Duration? throttleDuration;
  final _ParentTappableState? parentState;
  final GestureLongPressCallback? onLongPress;
  final GestureLongPressMoveUpdateCallback? onLongPressMoveUpdate;
  final GestureLongPressStartCallback? onLongPressStart;
  final GestureLongPressEndCallback? onLongPressEnd;
  final List<BoxShadow>? boxShadow;
  final ScaleStrength? scaleStrength;
  final FadeStrength? fadeStrength;
  final Alignment? scaleAlignment;

  @override
  State<_TappableStateWidget> createState() => _TappableStateWidgetState();
}

class _TappableStateWidgetState extends State<_TappableStateWidget>
    with SingleTickerProviderStateMixin
    implements _ParentTappableState {
  final ObserverList<_ParentTappableState> _activeChildren =
      ObserverList<_ParentTappableState>();

  @override
  void markChildTappablePressed(
    _ParentTappableState childState,
    bool value,
  ) {
    final lastAnyPressed = _anyChildTappablePressed;
    if (value) {
      _activeChildren.add(childState);
    } else {
      _activeChildren.remove(childState);
    }
    final nowAnyPressed = _anyChildTappablePressed;
    if (nowAnyPressed != lastAnyPressed) {
      widget.parentState?.markChildTappablePressed(this, nowAnyPressed);
    }
  }

  bool get _anyChildTappablePressed => _activeChildren.isNotEmpty;

  void updateHighlight({required bool value}) {
    widget.parentState?.markChildTappablePressed(this, value);
  }

  static const animationOutDuration = Duration(milliseconds: 150);
  static const animationInDuration = Duration(milliseconds: 230);
  final Tween<double> _animationTween = Tween<double>(begin: 1);
  late double _animationValue = switch (widget.variant) {
    TappableVariant.faded => widget.fadeStrength!.strength,
    TappableVariant.scaled => widget.scaleStrength!.strength,
    _ => 0.0,
  };

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      value: 0,
      vsync: this,
    );
    _animation = _animationController
        .drive(CurveTween(curve: Curves.decelerate))
        .drive(_animationTween);
    _setTween();
  }

  @override
  void didUpdateWidget(covariant _TappableStateWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.scaleStrength != widget.scaleStrength) {
      _animationValue = widget.scaleStrength?.strength ?? 0;
    } else if (oldWidget.fadeStrength != widget.fadeStrength) {
      _animationValue = widget.fadeStrength?.strength ?? 0;
    }
  }

  void _setTween() {
    _animationTween.end = 0.5;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  bool _buttonHeldDown = false;

  void Function()? _handleTap() {
    if (widget.onTap == null) return null;
    return () {
      updateHighlight(value: false);
      if (widget.onTap != null) {
        if (widget.enableFeedback) {
          Feedback.forTap(context);
        }
        widget.onTap!.call();
      }
    };
  }

  void _handleTapDown(TapDownDetails event) {
    if (_anyChildTappablePressed) return;
    updateHighlight(value: true);
    if (!_buttonHeldDown) {
      _buttonHeldDown = true;
      _animate();
      widget.onTapDown?.call(event);
    }
  }

  void _handleTapUp(TapUpDetails event) {
    if (_buttonHeldDown) {
      _buttonHeldDown = false;
    }
    if (_animationController.value < _animationValue) {
      _animationController
          .animateTo(
            _animationValue,
            duration: animationOutDuration,
            curve: Curves.easeInOutCubicEmphasized,
          )
          .then(
            (value) => _animationController.animateTo(
              0,
              duration: animationInDuration,
              curve: Curves.easeOutCubic,
            ),
          );
      widget.onTapUp?.call(event);
    }
    if (_animationController.value >= _animationValue) {
      _animationController.animateTo(
        0,
        duration: animationInDuration,
        curve: Curves.easeOutCubic,
      );
    }
  }

  void _handleTapCancel() {
    if (_buttonHeldDown) {
      _buttonHeldDown = false;
      _animate();
    }
    updateHighlight(value: false);
  }

  void _handleLongPress() {
    _animate();
    if (widget.onLongPress != null) {
      if (widget.enableFeedback) {
        Feedback.forLongPress(context);
      }
      widget.onLongPress!.call();
    }
  }

  void _animate() {
    final wasHeldDown = _buttonHeldDown;
    _buttonHeldDown
        ? _animationController.animateTo(
            _animationValue,
            duration: animationOutDuration,
            curve: Curves.easeInOutCubicEmphasized,
          )
        : _animationController
            .animateTo(
            0,
            duration: animationInDuration,
            curve: Curves.easeOutCubic,
          )
            .then(
            (_) {
              if (mounted && wasHeldDown != _buttonHeldDown) {
                _animate();
              }
            },
          );
  }

  Future<void> _onPointerDown(PointerDownEvent event) async {
    // Check if right mouse button clicked
    if (event.kind == PointerDeviceKind.mouse &&
        event.buttons == kSecondaryMouseButton) {
      if (widget.onLongPress != null) widget.onLongPress!.call();
    }
  }

  @override
  void deactivate() {
    widget.parentState?.markChildTappablePressed(this, false);
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final animatedDecoratedBox = Semantics(
      button: true,
      child: _ButtonAnimationWrapper(
        variant: widget.variant,
        animation: _animation,
        scaleAlignment: widget.scaleAlignment,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius,
            color: widget.backgroundColor,
            boxShadow: widget.boxShadow,
          ),
          child: Padding(
            padding: widget.padding ?? EdgeInsets.zero,
            child: widget.child,
          ),
        ),
      ),
    );

    Widget button;
    Widget tappable({required VoidCallback? onTap, required Widget child}) =>
        MouseRegion(
          cursor: kIsWeb ? SystemMouseCursors.click : MouseCursor.defer,
          child: IgnorePointer(
            ignoring: widget.onLongPress == null && onTap == null,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onTap,
              onDoubleTap: widget.onDoubleTap,
              onTapUp: _handleTapUp,
              onTapDown: _handleTapDown,
              onTapCancel: _handleTapCancel,
              onLongPressStart: widget.onLongPressStart,
              onLongPressEnd: widget.onLongPressEnd,
              onLongPressMoveUpdate: widget.onLongPressMoveUpdate,
              // Use null so other long press actions can be captured
              onLongPress: widget.onLongPress == null ? null : _handleLongPress,
              child: child,
            ),
          ),
        );

    if (widget.throttle) {
      button = _ThrottledButton(
        onTap: _handleTap(),
        throttleDuration: widget.throttleDuration?.inMilliseconds,
        child: animatedDecoratedBox,
        builder: (isThrottled, onTap, child) =>
            tappable(onTap: onTap, child: child!),
      );
    } else {
      button = tappable(onTap: _handleTap(), child: animatedDecoratedBox);
    }

    if (!kIsWeb && widget.onLongPress != null) {
      return _ParentTappableProvider(state: this, child: button);
    }

    return _ParentTappableProvider(
      state: this,
      child: Listener(
        onPointerDown: _onPointerDown,
        child: button,
      ),
    );
  }
}
