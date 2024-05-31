import 'package:flutter/material.dart';
import 'package:my_app/core/constant/bottm_nav.dart';
import 'package:my_app/presentation/pages/main/chat/chat.screen.dart';
import 'package:my_app/presentation/pages/main/feed/feed.screen.dart';
import 'package:my_app/presentation/pages/main/home/home.screen.dart';
import 'package:my_app/presentation/pages/main/setting/setting.screen.dart';
import 'package:my_app/presentation/pages/main/short/short.screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  _handleOnPageChanged(int index) {
    _pageController.animateToPage(index,
        duration: const Duration(microseconds: 500), curve: Curves.easeIn);
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
          pageSnapping: true,
          itemCount: BottomNav.values.length,
          controller: _pageController,
          onPageChanged: _handleOnPageChanged,
          itemBuilder: (context, index) {
            switch (BottomNav.values[index]) {
              case BottomNav.home:
                return const HomeScreen();
              case BottomNav.feed:
                return const FeedScreeen();
              case BottomNav.short:
                return const ChatScreen();
              case BottomNav.chat:
                return const ShortScreen();
              case BottomNav.setting:
                return const SettingScreen();
            }
          }),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _handleOnPageChanged,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: BottomNav.values
            .map((e) => BottomNavigationBarItem(
                label: e.label,
                icon: Icon(e.iconData),
                activeIcon: Icon(e.activeIconData)))
            .toList(),
      ),
    );
    ;
  }
}
