import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_prj/screen/widgets/chat_widget.dart';
import 'package:flutter_prj/states_management/home/home_cubit.dart';
import 'package:flutter_prj/states_management/home/home_state.dart';

import '../../widgets/active_user_widget.dart';
import '../../widgets/profile_image_widget.dart';

class Home extends StatefulWidget {
  const Home();

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().activeUsers();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            /// 로그인 유저 프로필
            title: _loginUserProfile(),

            /// 탭바
            bottom: TabBar(
              indicatorPadding: const EdgeInsets.only(top: 10, bottom: 10),
              tabs: [
                _messageTab(),
                _activeUserTab(),
              ],
            ),
          ),
          body: const TabBarView(
            children: [Chats(), ActiveUsers()],
          ),
        ));
  }

  Widget _loginUserProfile() => Container(
        width: double.maxFinite,
        child: Row(
          children: [
            // TODO : 썸네일 이미지 주소
            const ProfileImage(
                imageUrl: "https://picsum.photos/seed/picsum/200/300"),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    "TEST",
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        .copyWith(fontSize: 14.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child:
                      Text("TEST", style: Theme.of(context).textTheme.caption),
                ),
              ],
            )
          ],
        ),
      );

  Tab _messageTab() => Tab(
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
          child: Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.message_rounded),
                Container(
                    margin: EdgeInsets.only(left: 10.0), child: Text("메세지"))
              ],
            ),
          ),
        ),
      );

  Tab _activeUserTab() => Tab(
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
          child: Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.people_outline_rounded),
                  BlocBuilder<HomeCubit, HomeState>(
                      builder: (_, state) => state is HomeSuccess
                          ? Text('활동 중 유저(${state.activeUsers.length})')
                          : Text('활동 중 유저(0)')),
                ],
              )),
        ),
      );
}
