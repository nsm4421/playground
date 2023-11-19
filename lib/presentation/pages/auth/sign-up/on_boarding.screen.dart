import 'package:flutter/material.dart';
import 'package:my_app/presentation/pages/auth/sign-up/component/description.fragment.dart';
import 'package:my_app/presentation/pages/auth/sign-up/component/nickname.fragment.dart';
import 'package:my_app/presentation/pages/auth/sign-up/component/profile_image.fragment.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late PageController _pageController;
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _pages = <Widget>[
      NicknameFragment(pageController: _pageController, currentPage: 0),
      ProfileImageFragment(pageController: _pageController, currentPage: 1),
      DescriptionFragment(_pageController),
    ];
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                  child: PageView.builder(
                      pageSnapping: true,
                      itemCount: _pages.length,
                      controller: _pageController,
                      itemBuilder: (_, index) => _pages[index]))
            ],
          ),
        ),
      );
}
