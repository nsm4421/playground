import 'package:chat/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_prj/screen/widgets/profile_image_widget.dart';
import 'package:flutter_prj/states_management/home/home_cubit.dart';
import 'package:flutter_prj/states_management/home/home_state.dart';

class ActiveUsers extends StatefulWidget {
  const ActiveUsers({Key key}) : super(key: key);

  @override
  State<ActiveUsers> createState() => _ActiveUsersState();
}

class _ActiveUsersState extends State<ActiveUsers> {
  @override
  Widget build(BuildContext context) => BlocBuilder<HomeCubit, HomeState>(
        builder: (_, state) {
          if (state is HomeLoading) return _loading();
          if (state is HomeSuccess) return _activeUserList(state.activeUsers);
          return Container();
        },
      );

  ListTile _activeUserItem(User user) => ListTile(
        leading: ProfileImage(
          imageUrl: user.photoUrl,
          isInternetConnected: true,
        ),
        title: Text(
          user.username,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              .copyWith(fontSize: 14.0, fontWeight: FontWeight.bold),
        ),
      );

  _activeUserList(List<User> users) => ListView.separated(
      itemBuilder: (BuildContext context, idx) => _activeUserItem(users[idx]),
      separatorBuilder: (_, __) => const Divider(),
      itemCount: users.length);

  Widget _loading() => const Center(
        child: CircularProgressIndicator(),
      );
}
