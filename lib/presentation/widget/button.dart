part of 'widget.dart';

class RoundedIconWidget extends StatelessWidget {
  final IconData iconData;
  final double size;
  final void Function()? onTap;
  final Color? bgColor;
  final Color? iconColor;

  const RoundedIconWidget(
      {super.key,
      required this.iconData,
      required this.size,
      this.onTap,
      this.bgColor,
      this.iconColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: bgColor ?? CustomPalette.darkGrey),
        child: Icon(
          iconData,
          size: size,
          color: iconColor ?? CustomPalette.white,
        ),
      ),
    );
  }
}
