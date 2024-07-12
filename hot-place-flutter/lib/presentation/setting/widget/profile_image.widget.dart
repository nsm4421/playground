import 'package:flutter/material.dart';

class ProfileImageWidget extends StatelessWidget {
  const ProfileImageWidget(this.profileImage, {super.key, this.radius = 18});

  final String? profileImage;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        radius: radius,
        child: profileImage != null
            ? Container(
                width: 2 * radius,
                height: 2 * radius,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(profileImage!), fit: BoxFit.cover)))
            : const Icon(Icons.question_mark));
  }
}
