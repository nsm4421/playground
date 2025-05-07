part of 'snackbar.dart';

class SnackBarWidget extends StatefulWidget {
  const SnackBarWidget({super.key});

  @override
  State<SnackBarWidget> createState() => SnackBarWidgetState();
}

class SnackBarWidgetState extends State<SnackBarWidget>
    with TickerProviderStateMixin {
  PausableTimer? currentTimeout;

  late AnimationController _animationControllerY;
  late AnimationController _animationControllerX;
  late AnimationController _animationControllerErrorShake;

  /// Total moved negative.
  double totalMovedNegative = 0;

  /// Current queue of snackbar messages.
  List<SnackBarMessageItem> currentQueue = [];

  /// Current snackbar message.
  SnackBarMessageItem? currentMessage;

  /// Posts a new snackbar message to the queue.
  void post(
    SnackBarMessageItem message, {
    required bool clearIfQueue,
    required bool undismissable,
  }) {
    if (clearIfQueue && currentQueue.isNotEmpty) {
      currentQueue.add(message);
      animateOut();
      return;
    }
    currentQueue.add(message);
    if (currentQueue.length <= 1) {
      animateIn(message, undismissable: undismissable);
    }
  }

  /// Animates the current snackbar out and the next one in.
  void animateIn(SnackBarMessageItem message, {bool undismissable = false}) {
    setState(() {
      currentMessage = currentQueue[0];
    });
    _animationControllerX.animateTo(0.5, duration: Duration.zero);
    _animationControllerY.animateTo(
      0.5,
      curve: const ElasticOutCurve(0.8),
      duration: Duration(
        milliseconds:
            ((_animationControllerY.value - 0.5).abs() * 800 + 900).toInt(),
      ),
    );
    if (message.isError) {
      shake();
    }
    currentTimeout = PausableTimer(message.timeout, animateOut);
    currentTimeout!.start();
  }

  /// Animates the current snackbar out.
  void animateOut() {
    currentTimeout?.cancel();
    _animationControllerY.animateTo(
      0,
      curve: Curves.elasticOut,
      duration: Duration(
        milliseconds:
            ((_animationControllerY.value - 0.5).abs() * 800 + 2000).toInt(),
      ),
    );

    if (currentQueue.isNotEmpty) {
      currentQueue.removeAt(0);
    }
    if (currentQueue.isNotEmpty) {
      Future.delayed(const Duration(milliseconds: 150), () {
        animateIn(currentQueue[0]);
      });
    }
  }

  /// Closes all snackbar messages.
  void closeAll() {
    currentQueue.clear();
    currentTimeout?.cancel();
    _animationControllerY.animateTo(
      0,
      curve: Curves.elasticOut,
      duration: Duration(
        milliseconds:
            ((_animationControllerY.value - 0.5).abs() * 800 + 2000).toInt(),
      ),
    );
  }

  /// Shakes the current snackbar in case of error.
  void shake() => _animationControllerErrorShake.forward();

  @override
  void initState() {
    super.initState();

    _animationControllerY = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _animationControllerX = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _animationControllerErrorShake = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..addStatusListener(_updateStatus);
  }

  void _updateStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _animationControllerErrorShake.reset();
    }
  }

  void _onPointerMove(PointerMoveEvent ptr) {
    if (ptr.delta.dy <= 0) {
      totalMovedNegative += ptr.delta.dy;
    }
    if (_animationControllerY.value <= 0.5) {
      _animationControllerY.value += ptr.delta.dy / 400;
    } else {
      _animationControllerY.value +=
          ptr.delta.dy / (2000 * _animationControllerY.value * 8);
    }
    _animationControllerX.value +=
        ptr.delta.dx / (1000 + (_animationControllerX.value - 0.5).abs() * 100);

    currentTimeout!.pause();
  }

  void _onPointerUp(PointerUpEvent event) {
    if (totalMovedNegative <= -200) {
      // if user drags it around but has a net negative, swipe up
      animateOut();
    } else if (_animationControllerY.value <= 0.4) {
      // it is swiped up
      animateOut();
    } else {
      _animationControllerY.animateTo(
        0.5,
        curve: Curves.elasticOut,
        duration: Duration(
          milliseconds:
              ((_animationControllerY.value - 0.5).abs() * 800 + 700).toInt(),
        ),
      );

      currentTimeout!.start();
    }

    _animationControllerX.animateTo(
      0.5,
      curve: Curves.elasticOut,
      duration: Duration(
        milliseconds:
            ((_animationControllerX.value - 0.5).abs() * 800 + 700).toInt(),
      ),
    );
    totalMovedNegative = 0;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationControllerX,
      builder: (context, child) {
        return child!;
      },
      child: AnimatedBuilder(
        animation: _animationControllerY,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(
              (_animationControllerX.value - 0.5) * 100,
              (_animationControllerY.value - 0.5) * 400 +
                  context.viewPadding.top +
                  10,
            ),
            child: child,
          );
        },
        child: Listener(
          onPointerMove: _onPointerMove,
          onPointerUp: _onPointerUp,
          child: Center(
            child: Align(
              alignment: Alignment.topCenter,
              child: AnimatedBuilder(
                animation: _animationControllerErrorShake,
                builder: (context, child) {
                  final sineValue = sin(
                    currentMessage?.shakeCount ??
                        3 * 2 * pi * _animationControllerErrorShake.value,
                  );
                  final shakeOffset = currentMessage?.shakeOffset ?? 10;
                  return Transform.translate(
                    offset: Offset(sineValue * shakeOffset, 0),
                    child: child,
                  );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    // 박스 배경색
                    color: currentMessage?.backgroundColor,
                    boxShadow: [
                      BoxShadow(
                        color: CustomPalette.darkGrey.withOpacity(0.1),
                        blurRadius: 15,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: GestureDetector(
                    onTap: () {
                      if (currentMessage?.onTap != null) {
                        currentMessage?.onTap!.call();
                      }
                      animateOut();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              if (currentMessage?.icon == null)
                                const SizedBox.shrink()
                              else
                                Padding(
                                  padding: const EdgeInsets.only(
                                    right: 16 - 4,
                                  ),

                                  /// 아이콘
                                  child: Icon(
                                    currentMessage?.icon,
                                    size: currentMessage?.iconSize ?? 21,
                                    color: currentMessage?.iconColor ??
                                        CustomPalette.white,
                                  ),
                                ),
                              if (currentMessage?.isLoading == null)
                                const SizedBox.shrink()
                              else if (currentMessage?.isLoading != null &&
                                  currentMessage!.isLoading == true)
                                const Padding(
                                  padding: EdgeInsets.only(
                                    right: 16 - 4,
                                  ),
                                  child: SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  ),
                                ),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment:
                                      currentMessage?.icon == null
                                          ? CrossAxisAlignment.center
                                          : CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      currentMessage?.icon == null
                                          ? MainAxisAlignment.center
                                          : MainAxisAlignment.start,
                                  children: [
                                    /// title
                                    Text(
                                      currentMessage?.title ?? '',
                                      style: context.textTheme.titleMedium
                                          ?.copyWith(
                                              color:
                                                  currentMessage?.iconColor ??
                                                      CustomPalette.white),
                                      textAlign: currentMessage?.icon == null
                                          ? TextAlign.center
                                          : TextAlign.left,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                    ),

                                    /// description
                                    if (currentMessage?.description != null)
                                      Text(
                                        currentMessage?.description ?? '',
                                        style: context.textTheme.bodyLarge
                                            ?.copyWith(
                                                color:
                                                    currentMessage?.iconColor ??
                                                        CustomPalette.white),
                                        textAlign: currentMessage?.icon == null
                                            ? TextAlign.center
                                            : TextAlign.left,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 3,
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
