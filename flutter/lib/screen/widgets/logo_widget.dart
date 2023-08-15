import 'package:flutter/material.dart';

import '../custom_design/theme.dart';

Widget _logoImage(BuildContext context) {
  // TODO : 로고 이미지 수정
  const lightThemeLogoImageSrc = 'assets/images/logo.png';
  const darkThemeLogoImageSrc = 'assets/images/logo.png';
  return (isLightTheme(context)
      ? Image.asset(
          lightThemeLogoImageSrc,
          fit: BoxFit.fill,
        )
      : Image.asset(
          darkThemeLogoImageSrc,
          fit: BoxFit.fill,
        ));
}

TextStyle _logoTextStyle(BuildContext context) {
  return Theme.of(context)
      .textTheme
      .headlineMedium
      .copyWith(fontWeight: FontWeight.bold);
}

Widget logoWidget(BuildContext context) {
  TextStyle logoTextStyle = _logoTextStyle(context);

  return SizedBox(
    height: 50,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text("Chat", style: logoTextStyle),

        /// logo image
        _logoImage(context),

        /// logo text
        Text("App", style: logoTextStyle),
      ],
    ),
  );
}
