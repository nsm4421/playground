import 'package:chat_app/screen/auth/s_login.dart';
import 'package:chat_app/screen/service/chat/s_chat.dart';
import 'package:chat_app/screen/service/feed/s_feed.dart';
import 'package:chat_app/screen/service/home/s_home.dart';
import 'package:chat_app/screen/service/my-page/s_my_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class IndexScreen extends StatefulWidget {
  const IndexScreen({super.key});

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  int _selectedIndex = 0;

  _bottomNavBar() => NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (idx) {
          setState(() {
            _selectedIndex = idx;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(
              Icons.home,
            ),
            label: "Home",
          ),
          NavigationDestination(
            icon: Icon(
              Icons.photo_album,
            ),
            label: "Feed",
          ),
          NavigationDestination(
            icon: Icon(
              Icons.chat,
            ),
            label: "Chat",
          ),
          NavigationDestination(
              icon: Icon(
                Icons.account_circle,
              ),
              label: "My Page"),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          /// 로그인 안 된 경우, 로그인 화면으로 보내기
          if (!snapshot.hasData) {
            return const LoginScreen();
          }
          return Scaffold(
            body: IndexedStack(
              index: _selectedIndex,
              children: const [
                HomeFragment(),
                FeedScreen(),
                ChatScreen(),
                MyPageScreen(),
              ],
            ),
            bottomNavigationBar: _bottomNavBar(),
          );
        },
      ),
    );
  }
}
