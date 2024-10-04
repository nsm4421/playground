part of 'util.dart';

mixin class CustomSnackBarUtil {
  void _showSnackBar(
      {required BuildContext context,
      required String message,
      String actionLabel = '닫기',
      required _SnackBarType type,
      int durationInSec = 2,
      Color? bgColor,
      Color? textColor,
      SnackBarAction? showActionWidget}) {
    final $textColor = textColor ?? Colors.white;
    final $bgColor = bgColor ?? Colors.black;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(type.iconData, color: $textColor, size: 20),
              const SizedBox(width: 8),
              Text(message,
                  softWrap: true,
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(color: $textColor))
            ],
          ),
          showCloseIcon: true,
          backgroundColor: $bgColor,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          elevation: 0,
          action: showActionWidget != null
              ? SnackBarAction(
                  label: actionLabel,
                  textColor: $textColor,
                  onPressed: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  })
              : null,
          duration: Duration(seconds: durationInSec)),
    );
  }

  showSuccessSnackBar(
      {required BuildContext context,
      required String message,
      String actionLabel = '닫기',
      int durationInSec = 2,
      Color? bgColor,
      Color? textColor,
      SnackBarAction? showActionWidget}) {
    _showSnackBar(
        context: context,
        message: message,
        actionLabel: actionLabel,
        type: _SnackBarType.success,
        durationInSec: durationInSec,
        bgColor: bgColor,
        textColor: textColor,
        showActionWidget: showActionWidget);
  }

  showInfoSnackBar(
      {required BuildContext context,
      required String message,
      String actionLabel = '닫기',
      int durationInSec = 2,
      Color? bgColor,
      Color? textColor,
      SnackBarAction? showActionWidget}) {
    _showSnackBar(
        context: context,
        message: message,
        actionLabel: actionLabel,
        type: _SnackBarType.info,
        durationInSec: durationInSec,
        bgColor: bgColor,
        textColor: textColor,
        showActionWidget: showActionWidget);
  }

  showErrorSnackBar(
      {required BuildContext context,
      required String message,
      String actionLabel = '닫기',
      int durationInSec = 2,
      Color? bgColor,
      Color? textColor,
      SnackBarAction? showActionWidget}) {
    _showSnackBar(
        context: context,
        message: message,
        actionLabel: actionLabel,
        type: _SnackBarType.error,
        durationInSec: durationInSec,
        bgColor: bgColor,
        textColor: textColor,
        showActionWidget: showActionWidget);
  }

  showWarningSnackBar(
      {required BuildContext context,
      required String message,
      String actionLabel = '닫기',
      int durationInSec = 2,
      Color? bgColor,
      Color? textColor,
      SnackBarAction? showActionWidget}) {
    _showSnackBar(
        context: context,
        message: message,
        actionLabel: actionLabel,
        type: _SnackBarType.warning,
        durationInSec: durationInSec,
        bgColor: bgColor,
        textColor: textColor,
        showActionWidget: showActionWidget);
  }
}

enum _SnackBarType {
  info(Icons.info_outline),
  success(Icons.check),
  warning(Icons.warning_amber),
  error(Icons.error_outlined);

  final IconData iconData;

  const _SnackBarType(this.iconData);
}
