import 'package:chat_app/screen/service/chat/f_chat.dart';
import 'package:chat_app/screen/service/home/s_home.dart';
import 'package:chat_app/screen/service/search/s_search.dart';
import 'package:chat_app/screen/service/setting/f_setting.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IndexScreen extends StatefulWidget {
  const IndexScreen({super.key});

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  int _selectedIndex = 0;



  _botomNavBar() => NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (idx) {
          setState(() {
            _selectedIndex = idx;
          });
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: "Home"),
          NavigationDestination(icon: Icon(Icons.search), label: "Search"),
          NavigationDestination(icon: Icon(Icons.chat), label: "Chat"),
          NavigationDestination(icon: Icon(Icons.settings), label: "Setting"),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: const [
            HomeFragment(),
            SearchFragment(),
            ChatFragment(),
            SettingFragment(),
          ],
        ),
        bottomNavigationBar: _botomNavBar(),
      ),
    );
  }
}
