part of 'widgets.dart';

class RoundIconButtonWidget extends StatelessWidget {
  const RoundIconButtonWidget(
      {super.key,
      required this.voidCallback,
      required this.iconData,
      this.tooltip,
      this.iconSize = 40,
      this.iconColor = Colors.white,
      this.bgColor = Colors.blueGrey,
      this.isLoading = false});

  final void Function() voidCallback;
  final IconData iconData;
  final String? tooltip;
  final double iconSize;
  final Color iconColor;
  final Color bgColor;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        tooltip: tooltip,
        onPressed: voidCallback,
        icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(shape: BoxShape.circle, color: bgColor),
            child: isLoading
                ? Transform.scale(
                    scale: 0.5, child: const CircularProgressIndicator())
                : Icon(iconData, color: iconColor, size: iconSize)));
  }
}
