part of '../export.core.dart';

mixin class DebounceMixIn {
  final Duration _debounceDuration = 200.ms;

  Timer? _timer;

  void debounce(VoidCallback callback) {
    if (_timer?.isActive ?? false) _timer?.cancel();
    _timer = Timer(_debounceDuration, callback);
  }
}
