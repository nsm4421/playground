import 'package:flutter/material.dart';
import 'package:flutter_prj/screen/custom_design/colors.dart';
import 'package:flutter_prj/screen/custom_design/theme.dart';

class ProfileImage extends StatelessWidget {
  final String imageUrl;
  final bool isInternetConnected;

  const ProfileImage(
      {Key key, @required this.imageUrl, this.isInternetConnected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.transparent,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(128.0),
            child: Image.network(
              imageUrl,
              width: 126.0,
              height: 126.0,
              fit: BoxFit.fill,
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: isInternetConnected ? OnlineIndicator() : Container(),
          )
        ],
      ),
    );
  }
}

class OnlineIndicator extends StatelessWidget {
  const OnlineIndicator({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 15.0,
      width: 15.0,
      decoration: BoxDecoration(
          color: kIndicatorBubble,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
              width: 3.0,
              color: isLightTheme(context) ? Colors.white : Colors.black)),
    );
  }
}
