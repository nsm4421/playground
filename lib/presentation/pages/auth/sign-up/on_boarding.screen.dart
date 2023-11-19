import 'package:flutter/material.dart';
import 'package:my_app/presentation/pages/auth/sign-up/component/detail.fragment.dart';
import 'package:my_app/presentation/pages/auth/sign-up/component/nickname.fragment.dart';
import 'package:my_app/presentation/pages/auth/sign-up/component/on_boarding_layout.widget.dart';
import 'package:my_app/presentation/pages/auth/sign-up/component/profile_image.fragment.dart';
import 'package:my_app/presentation/pages/auth/sign-up/component/welcome.screen.dart';

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
      OnBoardingLayout(currentPage: 0, pageController: _pageController, fragment: const WelcomeFragment(), isFirstPage: true),
      OnBoardingLayout(currentPage: 1, pageController: _pageController, fragment: const NicknameFragment()),
      OnBoardingLayout(currentPage: 2, pageController: _pageController, fragment: const ProfileImageFragment()),
      OnBoardingLayout(currentPage: 3, pageController: _pageController, fragment: const DetailFragment(), isLastPage: true),
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
