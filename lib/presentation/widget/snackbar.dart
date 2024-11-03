part of 'widget.dart';

class CustomSnackBar extends StatefulWidget {
  CustomSnackBar(
      {super.key,
      SnackBarType? type,
      required this.title,
      this.shake = false,
      this.description,
      Duration? duration}) {
    this.type = type ?? SnackBarType.info;
    this.duration = duration ?? (2.0).sec;
  }

  late final SnackBarType type;
  final String title;
  final bool shake;
  final String? description;
  late final Duration duration;

  @override
  State<CustomSnackBar> createState() => _CustomSnackBarState();
}

class _CustomSnackBarState extends State<CustomSnackBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _shakeAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween<double>(begin: 0, end: 8), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: 8, end: -8), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: -8, end: 4), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: 4, end: -4), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: -4, end: 0), weight: 1),
    ]).animate(_controller);

    _controller.forward();
    Future.delayed(widget.duration, () {
      _controller.reverse();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.translate(
            offset:
                widget.shake ? Offset(_shakeAnimation.value, 0) : Offset.zero,
            child: child,
          );
        },
        child: Material(
          color: widget.type.bgColor,
          elevation: 6,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                        switch (widget.type) {
                          SnackBarType.info => Icons.info_outline,
                          SnackBarType.success => Icons.info_outline,
                          SnackBarType.warning => Icons.info_outline,
                          SnackBarType.error => Icons.info_outline,
                        },
                        color: context.colorScheme.onPrimary),
                    (12.0).w,
                    Text(
                      widget.title,
                      softWrap: true,
                      style: context.textTheme.titleMedium
                          ?.copyWith(color: widget.type.textColor),
                    ),
                  ],
                ),
                if (widget.description != null)
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      (12.0).h,
                      Text(
                        widget.description ?? '',
                        softWrap: true,
                        style: context.textTheme.bodyLarge
                            ?.copyWith(color: widget.type.textColor),
                      ),
                    ],
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
