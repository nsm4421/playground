import 'package:flutter/material.dart';

class OnBoardingLayout extends StatelessWidget {
  const OnBoardingLayout(
      {super.key,
        this.isFirstPage = false,
        this.isLastPage = false,
        required this.currentPage,
        required this.pageController,
        required this.fragment});

  final bool isFirstPage;
  final bool isLastPage;
  final int currentPage;
  final PageController pageController;
  final Widget fragment;

  _handleGoToPrevious() => pageController.animateToPage(currentPage - 1,
      duration: const Duration(milliseconds: 500), curve: Curves.easeOut);

  _handleGoToNext() => pageController.animateToPage(currentPage + 1,
      duration: const Duration(milliseconds: 500), curve: Curves.easeOut);

  @override
  Widget build(BuildContext context) => SafeArea(
    child: Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
          elevation: 0,
          leading: isFirstPage
              ? const SizedBox()
              : IconButton(
              icon: const Icon(
                  Icons.keyboard_double_arrow_left_outlined,
                  color: Colors.grey),
              onPressed: _handleGoToPrevious),
          actions: [
            isLastPage
                ? const SizedBox()
                : IconButton(
                icon: const Icon(
                    Icons.keyboard_double_arrow_right_outlined,
                    color: Colors.grey),
                onPressed: _handleGoToNext)
          ]),
      body: SingleChildScrollView(
        child: fragment,
      ),
    ),
  );
}
