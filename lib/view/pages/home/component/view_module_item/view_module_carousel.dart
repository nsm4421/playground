import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../../common/theme/constant/app_colors.dart';
import '../../../../../domain/model/view_module_model.dart';

class ViewModuleCarousel extends StatefulWidget {
  const ViewModuleCarousel(this.viewModuleModel, {super.key});

  final ViewModuleModel viewModuleModel;

  @override
  State<ViewModuleCarousel> createState() => _ViewModuleCarouselState();
}

class _ViewModuleCarouselState extends State<ViewModuleCarousel> {
  static const double _aspectRatio = 375 / 340;
  static const int _secToNextImage = 4;
  static const int _milliSecToSide = 500;

  int _currentPage = 1;
  late PageController _pageController;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    // 4초에 한번씩 다음 이미지로
    _timer = Timer.periodic(Duration(seconds: _secToNextImage), _onNextPage);
  }

  // 다음 페이지로 이동할 때 수행할 동작
  _onNextPage(Timer _) {
    _pageController.nextPage(
      duration: Duration(milliseconds: _milliSecToSide),
      curve: Curves.ease,
    );
  }

  _onPageChanged(int page) {
    setState(() {
      _currentPage = page % widget.viewModuleModel.products.length + 1;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: _aspectRatio,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemBuilder: (BuildContext _, int index) {
              final products = widget.viewModuleModel.products;
              final product = products[index % products.length];

              return Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
              );
            },
          ),
          PageCountWidget(
            currentPage: _currentPage,
            totalPage: widget.viewModuleModel.products.length,
          ),
        ],
      ),
    );
  }
}

class PageCountWidget extends StatelessWidget {
  const PageCountWidget({
    super.key,
    required this.currentPage,
    required this.totalPage,
  });

  static const double _opacity = 0.75;
  static const double _borderRadius = 20;
  static const double _horizontalPadding = 8;
  static const double _verticalPadding = 2;
  static const double _marginSize = 8;

  final int currentPage;
  final int totalPage;

  @override
  Widget build(BuildContext context) => Align(
        alignment: Alignment.bottomRight,
        child: Container(
          padding: EdgeInsets.all(_marginSize),
          decoration: BoxDecoration(
            color: Theme.of(context)
                .colorScheme
                .inverseSurface
                .withOpacity(_opacity),
            borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: _verticalPadding,
              horizontal: _horizontalPadding,
            ),
            child: Text(
              "$currentPage/$totalPage",
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(color: AppColors.white),
            ),
          ),
        ),
      );
}
