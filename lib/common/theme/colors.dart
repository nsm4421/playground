import 'package:flutter/material.dart';

class LightColors {
  Color get green => const Color(0xFF008069);

  Color get blue => const Color(0xFF027EB5);

  Color get grey => const Color(0xFF667781);

  Color get background => const Color(0xFFFFFFFF);

  Color get greyBackground => const Color(0xFF202C33);
}

class DarkColors extends LightColors {
  @override
  Color get green => const Color(0xFF00A884);

  @override
  Color get blue => const Color(0xFF53BDEB);

  @override
  Color get grey => const Color(0xFF8696A0);

  @override
  Color get background => const Color(0xFF111B21);

  @override
  Color get greyBackground => const Color(0xFF202C33);
}
