part of '../export.core.dart';

extension BuildContextExtensionOnSnackBar on BuildContext {
  _content({
    required SnackBarType type,
    String? message,
    String? description,
  }) =>
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(switch (type) {
            SnackBarType.success => Icons.check,
            SnackBarType.error => Icons.error,
            SnackBarType.warning => Icons.warning_amber,
            SnackBarType.info => Icons.info_outline,
          }),
          12.width,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message ??
                    switch (type) {
                      SnackBarType.success => 'Success',
                      SnackBarType.error => 'Error',
                      SnackBarType.warning => 'Warning',
                      SnackBarType.info => 'Info',
                    },
                style:
                    textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w800),
              ),
              8.height,
              if (description != null)
                Text(
                  description,
                  style: textTheme.bodyLarge
                      ?.copyWith(fontWeight: FontWeight.w600),
                )
            ],
          )
        ],
      );

  _snackBar({
    required SnackBarType type,
    String? message,
    String? description,
    Duration? duration,
  }) {
    return SnackBar(
      backgroundColor: switch (type) {
        SnackBarType.success => colorScheme.primaryContainer,
        SnackBarType.info => colorScheme.tertiaryContainer,
        SnackBarType.warning => colorScheme.secondaryContainer,
        SnackBarType.error => colorScheme.errorContainer,
      },
      behavior: SnackBarBehavior.floating,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      content: _content(type: type, message: message, description: description),
      elevation: 0,
      duration: duration ?? 3.sec,
    );
  }

  void showSuccessSnackBar({
    String? message,
    String? description,
    Duration? duration,
  }) =>
      ScaffoldMessenger.of(this).showSnackBar(
        _snackBar(
            type: SnackBarType.success,
            message: message,
            description: description,
            duration: duration),
      );

  void showErrorSnackBar({
    String? message,
    String? description,
    Duration? duration,
  }) =>
      ScaffoldMessenger.of(this).showSnackBar(
        _snackBar(
            type: SnackBarType.error,
            message: message,
            description: description,
            duration: duration),
      );

  void showWarningSnackBar({
    String? message,
    String? description,
    Duration? duration,
  }) =>
      ScaffoldMessenger.of(this).showSnackBar(
        _snackBar(
            type: SnackBarType.warning,
            message: message,
            description: description,
            duration: duration),
      );

  void showInfoSnackBar({
    String? message,
    String? description,
    Duration? duration,
  }) =>
      ScaffoldMessenger.of(this).showSnackBar(
        _snackBar(
            type: SnackBarType.info,
            message: message,
            description: description,
            duration: duration),
      );
}
