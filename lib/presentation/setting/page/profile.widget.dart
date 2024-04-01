import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hot_place/data/entity/user/user.entity.dart';

import '../../../core/constant/route.constant.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget(this.user, {super.key});

  final UserEntity user;

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  _handleGoToEditProfilePage() {
    context.push(Routes.editProfile.path);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: CircleAvatar(
          child: widget.user.profileImage != null
              ? Image.network(widget.user.profileImage!)
              : const Icon(Icons.question_mark),
        ),
        title: Text("Nickname", style: Theme.of(context).textTheme.titleMedium),
        subtitle: Text("email@naver.com",
            style: Theme.of(context)
                .textTheme
                .labelMedium
                ?.copyWith(color: Theme.of(context).colorScheme.secondary)),
        trailing: IconButton(
            onPressed: _handleGoToEditProfilePage,
            icon: const Icon(Icons.edit)));
  }
}
