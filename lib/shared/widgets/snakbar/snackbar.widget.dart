part of 'snackbar.dart';

class SnakbarWidget extends StatefulWidget {
  const SnakbarWidget({super.key});

  @override
  State<SnakbarWidget> createState() => SnakbarWidgetState();
}

class SnakbarWidgetState extends State<SnakbarWidget>
    with TickerProviderStateMixin {
  static const int _durationOnShow = 1500; // 스낵바를 띄우는데까지 걸리는 시간
  static const int _durationOnDisplay = 15000; // 스낵바가 떠 있는 시간

  late AnimationController _horizontalAnimator;
  late AnimationController _verticalAnimator;
  late AnimationController _shakeAnimator;

  PausableTimer? _currentTimeout;
  final List<SnackbarMessage> _queue = [];
  SnackbarMessage? _currentMessage;

  @override
  void initState() {
    super.initState();
    _verticalAnimator = AnimationController(
      debugLabel: 'snackbar-vertical-animator',
      vsync: this,
      duration: const Duration(milliseconds: _durationOnDisplay),
    );
    _horizontalAnimator = AnimationController(
      debugLabel: 'snackbar-horzontal-animator',
      vsync: this,
      duration: const Duration(milliseconds: _durationOnDisplay),
    );
    _shakeAnimator = AnimationController(
      debugLabel: 'snackbar-shacke-animator',
      vsync: this,
      duration: const Duration(milliseconds: _durationOnDisplay),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _shakeAnimator.reset();
        }
      });
  }

  void add(SnackbarMessage message, {bool collapseAll = false}) {
    // 기존 메세지를 삭제하는 경우
    if (collapseAll) {
      _queue.clear();
      _currentTimeout?.cancel();
    }
    _queue.add(message);
    setState(() {
      _currentMessage = _queue.first;
    });
    // 애니메이션
    _horizontalAnimator.animateTo(0.5, duration: Duration.zero);
    _verticalAnimator.animateTo(
      0.5,
      duration: const Duration(milliseconds: _durationOnShow),
      curve: const ElasticOutCurve(0.8),
    );
    _currentTimeout = PausableTimer(_queue.first.timeout, () {
      _currentTimeout?.cancel();
      _verticalAnimator.animateTo(
        0,
        curve: Curves.elasticOut,
      );
      _queue.removeAt(0);
    });
    _shakeAnimator.forward();
    if (_currentMessage != null && _currentMessage!.isShake) {}
    _currentTimeout?.start();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _horizontalAnimator,
      builder: (context, child) => child ?? const SizedBox(),
      child: AnimatedBuilder(
          animation: _verticalAnimator,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(
                (_horizontalAnimator.value - 0.5) * 100,
                (_verticalAnimator.value - 0.5) * 400 +
                    MediaQuery.of(context).viewPadding.top +
                    10,
              ),
              child: child,
            );
          },
          child: _currentMessage == null
              ? const SizedBox()
              : SnackbarItemWidget(_currentMessage!)),
    );
  }
}
