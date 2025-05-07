part of 'snackbar.dart';

class SnackBarMessageItem {
  const SnackBarMessageItem({
    this.title = '',
    this.description,
    this.icon,
    this.iconSize,
    this.iconColor,
    this.timeout = const Duration(milliseconds: 3500),
    this.onTap,
    this.isError = false,
    this.shakeCount = 3,
    this.shakeOffset = 10,
    this.undismissable = false,
    this.dismissWhen,
    this.isLoading = false,
    this.backgroundColor,
  });

  const SnackBarMessageItem.success({
    String title = 'Successfully!',
    String? description,
    Duration timeout = const Duration(milliseconds: 3500),
  }) : this(
          title: title,
          description: description,
          icon: Icons.done,
          backgroundColor: const Color.fromARGB(255, 41, 166, 64),
          timeout: timeout,
        );

  /// {@macro snackbar_message_error}
  const SnackBarMessageItem.loading({
    String title = 'Loading...',
    Duration timeout = const Duration(milliseconds: 3500),
  }) : this(
          title: title,
          isLoading: true,
          timeout: timeout,
        );

  /// {@macro snackbar_message_error}
  const SnackBarMessageItem.error({
    String title = '',
    String? description,
    IconData? icon,
    Duration timeout = const Duration(milliseconds: 3500),
  }) : this(
          title: title,
          description: description,
          icon: icon ?? Icons.cancel_rounded,
          backgroundColor: const Color.fromARGB(255, 228, 71, 71),
          isError: true,
          timeout: timeout,
        );

  /// Snackbar title.
  final String title;

  /// Snackbar description.
  final String? description;

  /// Snackbar icon.
  final IconData? icon;

  /// The size of the icon.
  final double? iconSize;

  /// The color of the icon.
  final Color? iconColor;

  /// Snackbar duration before it disappears.
  final Duration timeout;

  /// Snackbar onTap callback.
  final VoidCallback? onTap;

  /// Returns true if the snackbar is an error.
  final bool isError;

  /// The number of times the snackbar should shake in case of error.
  final int shakeCount;

  /// The offset of the snackbar when it shakes.
  final int shakeOffset;

  /// Returns true if the snackbar is undismissable.
  final bool undismissable;

  /// Returns when the snackbar should be dismissed.
  final FutureOr<bool>? dismissWhen;

  /// Returns true if the snackbar is loading.
  final bool isLoading;

  /// The background color of the snackbar message.
  final Color? backgroundColor;
}
