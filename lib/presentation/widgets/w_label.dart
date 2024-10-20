part of 'widgets.dart';

class IconLabelWidget extends StatelessWidget {
  const IconLabelWidget({
    super.key,
    required this.iconData,
    required this.label,
    this.iconSize = 30,
    this.iconColor,
    this.textStyle,
  });

  final IconData iconData;
  final String label;
  final double iconSize;
  final Color? iconColor;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      SizedBox(
          width: iconSize + 20,
          child: Icon(iconData,
              size: iconSize,
              color: iconColor ?? Theme.of(context).colorScheme.tertiary)),
      const SizedBox(width: 12),
      Text(label,
          style: textStyle ??
              Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.w500))
    ]);
  }
}
