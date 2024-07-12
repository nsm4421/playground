import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hot_place/presentation/setting/bloc/user.bloc.dart';
import 'package:hot_place/presentation/setting/bloc/user.state.dart';
import 'package:hot_place/presentation/setting/widget/profile_image.widget.dart';

import '../../../core/constant/route.constant.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  _handleGoToEditProfilePage() {
    context.push(Routes.editProfile.path);
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<UserBloc, UserState>(
      builder: (_, state) => ListTile(
          leading: ProfileImageWidget(state.user.profileImage),
          title: Text(state.user.nickname ?? "Unknown",
              style: Theme.of(context).textTheme.titleMedium),
          subtitle: Text(state.user.email ?? '',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(color: Theme.of(context).colorScheme.secondary)),
          trailing: IconButton(
              onPressed: _handleGoToEditProfilePage,
              icon: const Icon(Icons.edit))));
}
