import 'package:flutter/material.dart';

import '../../../model/user/user.model.dart';

class UserProfileImageWidget extends StatelessWidget {
  const UserProfileImageWidget(this.user, {super.key});

  final UserModel user;
  static const double _borderRadius = 20;

  @override
  Widget build(BuildContext context) => Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 1.5,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(user.profileImageUrl!), fit: BoxFit.cover),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(_borderRadius),
            bottomRight: Radius.circular(_borderRadius),
          ),
        ),
      );
}
