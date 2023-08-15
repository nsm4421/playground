import 'package:flutter/material.dart';

import '../custom_design/colors.dart';

class ElevatedBtn extends StatelessWidget {
  final Function onPressed;
  final String btnText;
  final double height;

  const ElevatedBtn({Key key, this.onPressed, this.btnText, this.height = 45})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          primary: kPrimary,
          elevation: 5.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(45.0))),
      child: Container(
        height: 45.0,
        alignment: Alignment.center,
        child: Text(
          btnText,
          style: Theme.of(context).textTheme.button.copyWith(
              fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
