import 'package:flutter/material.dart';

var theme = ThemeData(

  // 텍스트 버튼
  textButtonTheme: TextButtonThemeData(
    style : TextButton.styleFrom(
      backgroundColor: Colors.white70
    )
  ),
  
  // 앱바
  appBarTheme: const AppBarTheme(
      color: Colors.white70,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      titleTextStyle: TextStyle(
          color : Colors.black, fontSize: 25, fontWeight: FontWeight.bold
      )
  ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedIconTheme: IconThemeData(
      color : Colors.amber
    ),
    unselectedIconTheme: IconThemeData(
      color : Colors.black
    )
  )
);

