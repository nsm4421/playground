import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/presentation/component/profile_list_tile.widget.dart';

import '../../../../core/enums/route.enum.dart';
import '../../../bloc/user/user.bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController _nicknameTec;

  @override
  void initState() {
    super.initState();
    _nicknameTec = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _nicknameTec.dispose();
  }

  _goToEditProfilePage() => context.push(RoutePath.editProfile.path);

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserBloc>().state.user;

    return Scaffold(
        appBar: AppBar(
          title: const Text("USER"),
        ),
        body: Column(
          children: [
            if (user != null)
              ProfileListTileWidget(
                  user: user,
                  trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: _goToEditProfilePage)),
          ],
        ));
  }
}
