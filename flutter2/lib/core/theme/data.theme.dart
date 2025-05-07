part of 'theme.dart';

final CustomTextTheme _textTheme = CustomTextTheme();
const CustomColorScheme _colorScheme = CustomColorScheme();

final customThemeData = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  colorScheme: _colorScheme,
  fontFamily: 'Pretendard',
  textTheme: _textTheme,
  dividerTheme: const DividerThemeData(color: CustomPalette.outline),
  tabBarTheme: TabBarTheme(
      indicator: const UnderlineTabIndicator(
        borderSide: BorderSide(color: CustomPalette.primary, width: 2),
      ),
      indicatorSize: TabBarIndicatorSize.tab,
      labelColor: _colorScheme.primary,
      labelStyle: _textTheme.titleSmall,
      unselectedLabelStyle: _textTheme.titleSmall,
      overlayColor:
          WidgetStatePropertyAll<Color>(Colors.grey[300] ?? Colors.grey)),
);
