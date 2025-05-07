import 'package:flutter/material.dart';
import 'package:my_app/domain/model/auth/user.model.dart';

class ProfileListTileWidget extends StatelessWidget {
  const ProfileListTileWidget({super.key, required this.user, this.trailing});

  final UserModel user;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) => ListTile(

      // 프로필 사진
      leading: user.profileImage != null
          ? CircleAvatar(
              child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(user.profileImage!)))))
          : null,

      // 닉네임
      title: Text(user.nickname ?? '???',
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontWeight: FontWeight.bold)),

      // 이메일
      subtitle: Text(user.email ?? ''),
      trailing: trailing);
}
