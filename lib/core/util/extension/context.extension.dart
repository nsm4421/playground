part of 'extension.dart';

extension BuildContextExtension on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  TextTheme get textTheme => Theme.of(this).textTheme;

  Size get size => MediaQuery.of(this).size;

  double get width => size.width;

  double get height => size.height;

  void showCustomSnackBar(
      {SnackBarType? type,
      required String title,
      String? description,
      bool shake = false,
      Duration? duration}) {
    final entry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 20,
        left: 16,
        right: 16,
        child: CustomSnackBar(
          type: type,
          title: title,
          shake: shake,
          description: description,
          duration: duration,
        ),
      ),
    );

    Overlay.of(this).insert(entry);
    Future.delayed(const Duration(seconds: 2), () {
      entry.remove();
    });
  }
}
