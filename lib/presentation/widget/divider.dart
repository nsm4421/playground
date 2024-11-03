part of 'widget.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({super.key, this.label});

  final String? label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider()),
        if (label != null)
          Text(label!,
              style: context.textTheme.labelMedium
                  ?.copyWith(color: CustomPalette.mediumGrey)),
        const Expanded(child: Divider()),
      ],
    );
  }
}
