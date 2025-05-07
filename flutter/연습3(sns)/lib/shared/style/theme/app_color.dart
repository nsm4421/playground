part of 'light_theme.dart';

abstract class AppColors {
  static const Color black = Color(0xFF000000);

  static const Color white = Color(0xFFFFFFFF);

  static const Color teal = Color.fromARGB(255, 0, 48, 43);

  static const Color darkTeal = Color.fromARGB(255, 0, 19, 17);

  static const Color lightBlue = Color.fromARGB(255, 100, 181, 246);

  static const Color lightBlueAccent = Colors.lightBlueAccent;

  static const Color deepOrange = Colors.deepOrange;

  static const Color deepOrangeAccent = Colors.deepOrangeAccent;

  static const Color indigo = Colors.indigo;

  static const Color blue = Color(0xFF3898EC);

  static const Color deepBlue = Color(0xff337eff);

  static const Color grey = Colors.grey;

  static const MaterialColor red = Colors.red;

  static const primaryGradient = <Color>[
    Color(0xFF833AB4),
    Color(0xFFF77737),
    Color(0xFFE1306C),
    Color(0xFFC13584),
    Color(0xFF833AB4),
  ];

  static const primaryBackgroundGradient = <Color>[
    Color.fromARGB(255, 119, 69, 121),
    Color.fromARGB(255, 141, 124, 189),
    Color.fromARGB(255, 50, 94, 170),
    Color.fromARGB(255, 111, 156, 189),
  ];

  static const primaryMessageBubbleGradient = <Color>[
    Color.fromARGB(255, 226, 128, 53),
    Color.fromARGB(255, 228, 96, 182),
    Color.fromARGB(255, 107, 73, 195),
    Color.fromARGB(255, 78, 173, 195),
  ];
}
