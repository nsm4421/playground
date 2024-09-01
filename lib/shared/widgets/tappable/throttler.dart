part of 'tappable.dart';

class _Throttler {
  _Throttler({this.milliseconds = 300});

  final int? milliseconds;

  Timer? timer;

  void run(VoidCallback action) {
    if (timer?.isActive ?? false) return;

    timer?.cancel();
    action();
    timer = Timer(
      Duration(milliseconds: milliseconds ?? 300),
      () {},
    );
  }

  /// Disposes the timer.
  void dispose() {
    timer?.cancel();
  }
}

class _ThrottledButton extends StatefulWidget {
  const _ThrottledButton({
    required this.onTap,
    required this.builder,
    required this.child,
    super.key,
    this.throttleDuration,
  });

  final VoidCallback? onTap;

  final int? throttleDuration;

  final Widget? child;

  final Widget Function(bool isThrottled, VoidCallback? onTap, Widget? child)
      builder;

  @override
  State<_ThrottledButton> createState() => _ThrottledButtonState();
}

class _ThrottledButtonState extends State<_ThrottledButton> {
  late _Throttler _throttler;

  late ValueNotifier<bool> _isThrottled;

  @override
  void initState() {
    super.initState();
    _throttler = _Throttler(milliseconds: widget.throttleDuration);
    _isThrottled = ValueNotifier(false);
  }

  @override
  void dispose() {
    _throttler.dispose();
    _isThrottled.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isThrottled,
      child: widget.child,
      builder: (context, isThrottled, _) {
        final onTap = isThrottled || widget.onTap == null
            ? null
            : () => _throttler.run(
                  () {
                    _isThrottled.value = true;
                    widget.onTap?.call();
                    Future<void>.delayed(
                      Duration(
                        milliseconds: widget.throttleDuration ??
                            _throttler.milliseconds ??
                            350,
                      ),
                      () => _isThrottled.value = false,
                    );
                  },
                );

        return widget.builder(isThrottled, onTap, widget.child);
      },
    );
  }
}
