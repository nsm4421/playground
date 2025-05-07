part of "custom_theme_data.dart";

enum FontWeights {
  regular(FontWeight.w400),
  semiBold(FontWeight.w600),
  bold(FontWeight.w700),
  extraBold(FontWeight.w900);

  final FontWeight weight;

  const FontWeights(this.weight);
}
