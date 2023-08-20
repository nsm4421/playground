import 'package:chat_app/common/theme/colors.dart';
import 'package:chat_app/common/theme/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Themes {
  /// getter
  ThemeData get lightTheme => _lightTheme();

  ThemeData get darkTheme => _darkTheme();

  /// light mode
  ThemeData _lightTheme() {
    final ThemeData base = ThemeData.light();
    final colors = LightColors();
    return base.copyWith(
      scaffoldBackgroundColor: colors.background,
      extensions: [CustomThemeExtension.lightMode],
      appBarTheme: AppBarTheme(
        backgroundColor: colors.green,
        titleTextStyle: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w600,
          color: Colors.white
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      tabBarTheme: const TabBarTheme(
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            color: Colors.white,
            width: 2,
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.green,
          foregroundColor: colors.background,
          splashFactory: NoSplash.splashFactory,
          elevation: 0,
          shadowColor: Colors.transparent,
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colors.background,
        modalBackgroundColor: colors.background,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
      ),
      dialogBackgroundColor: colors.background,
      dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colors.green,
        foregroundColor: Colors.white,
      ),
      listTileTheme: ListTileThemeData(
        iconColor: colors.grey,
        tileColor: colors.background,
      ),
      switchTheme: const SwitchThemeData(
        thumbColor: MaterialStatePropertyAll(Color(0xFF83939C)),
        trackColor: MaterialStatePropertyAll(Color(0xFFDADFE2)),
      ),
    );
  }

  /// dark mode
  ThemeData _darkTheme() {
    final ThemeData base = ThemeData.dark();
    final colors = DarkColors();
    return base.copyWith(
      scaffoldBackgroundColor: colors.background,
      extensions: [CustomThemeExtension.darkMode],
      appBarTheme: AppBarTheme(
        backgroundColor: colors.greyBackground,
        titleTextStyle: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w600,
          color: Colors.teal
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        iconTheme: IconThemeData(
          color: colors.grey,
        ),
      ),
      tabBarTheme: TabBarTheme(
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            color: colors.green,
            width: 2,
          ),
        ),
        unselectedLabelColor: colors.green,
        labelColor: colors.green,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.green,
          foregroundColor: colors.background,
          splashFactory: NoSplash.splashFactory,
          elevation: 0,
          shadowColor: Colors.transparent,
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colors.greyBackground,
        modalBackgroundColor: colors.greyBackground,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
      ),
      dialogBackgroundColor: colors.greyBackground,
      dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colors.green,
        foregroundColor: Colors.white,
      ),
      listTileTheme: ListTileThemeData(
        iconColor: colors.grey,
        tileColor: colors.background,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStatePropertyAll(colors.grey),
        trackColor: const MaterialStatePropertyAll(Color(0xFF344047)),
      ),
    );
  }
}
