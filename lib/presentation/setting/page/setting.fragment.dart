import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constant/route.constant.dart';

class SettingFragment extends StatelessWidget {
  const SettingFragment({super.key});

  goToEditPage(BuildContext context) =>
      () => context.push(Routes.editProfile.path);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          // 유저 프로필
          ListTile(
            onTap: () {},
            leading: const CircleAvatar(
                // TODO : 유저의 프로필 사진 가져오기
                child: Icon(Icons.question_mark)),
            title: Text(
              "유저 아이디",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary),
            ),
            subtitle: Text("유저 설명",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary)),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: goToEditPage(context),
              tooltip: "프로필 수정하기",
            ),
          ),
          SizedBox(height: 10),
          Divider(indent: 20, endIndent: 20),
          SizedBox(height: 10),
        ],
      );
}
