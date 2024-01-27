import 'package:flutter/material.dart';

import '../../core/enums/colors.enum.dart';

class TextButtonWidget extends StatelessWidget {
  const TextButtonWidget(
      {super.key,
      required this.label,
      this.onTap,
      this.colorScheme = CustomColorScheme.primary});

  final void Function()? onTap;
  final String label;
  final CustomColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    Color? textColor;
    Color? backgroundColor;

    final scheme = Theme.of(context).colorScheme;
    switch (colorScheme) {
      case CustomColorScheme.primary:
        textColor = scheme.onPrimary;
        backgroundColor = scheme.primary;
      case CustomColorScheme.secondary:
        textColor = scheme.onSecondary;
        backgroundColor = scheme.secondary;
      case CustomColorScheme.tertiary:
        textColor = scheme.onTertiary;
        backgroundColor = scheme.tertiary;
    }

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
            color: backgroundColor, borderRadius: BorderRadius.circular(20)),
        alignment: Alignment.center,
        child: Text(label,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.bold, color: textColor)),
      ),
    );
  }
}
