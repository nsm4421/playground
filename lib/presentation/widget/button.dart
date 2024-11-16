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

class ShadowedIconButton extends StatelessWidget {
  const ShadowedIconButton(
      {super.key,
      this.onTap,
      required this.iconData,
      this.iconSize,
      this.iconColor,
      this.shadowColor,
      this.angle});

  final void Function()? onTap;
  final IconData iconData;
  final double? iconSize;
  final Color? iconColor;
  final Color? shadowColor;
  final double? angle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Transform.rotate(
        angle: angle ?? 0,
        child: Stack(
          children: [
            Positioned(
              top: 4,
              left: 4,
              child: Icon(
                iconData,
                size: iconSize ?? 30,
                color: shadowColor ?? CustomPalette.shadow.withOpacity(0.5),
              ),
            ),
            // 실제 아이콘
            Icon(
              iconData,
              size: iconSize ?? 30,
              color: iconColor ?? CustomPalette.white,
            ),
          ],
        ),
      ),
    );
  }
}
