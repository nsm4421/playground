part of 'snackbar.dart';

enum SnakbarType {
  success,
  info,
  error;
}

class SnackbarMessage {
  final SnakbarType type;
  final String title;
  final String? description;
  final IconData? iconData;
  final Duration timeout;
  final VoidCallback? onTap;
  final Color bgColor;
  final Color textColor;
  final bool isShake;

  const SnackbarMessage({
    this.type = SnakbarType.success,
    this.title = '',
    this.description,
    this.iconData,
    required this.timeout,
    this.onTap,
    required this.bgColor,
    required this.textColor,
    this.isShake = false,
  });
}
