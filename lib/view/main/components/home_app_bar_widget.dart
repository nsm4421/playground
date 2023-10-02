import '../../../common/widget/size_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/theme/constant/icon_paths.dart';
import '../../../common/theme/custom/custom_font_weight.dart';
import '../../../common/theme/custom/custom_theme.dart';
import '../cubit/top_app_bar_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeAppBarWidget extends StatelessWidget {
  const HomeAppBarWidget({super.key});

  static const double _horizontalPadding = 8;
  static const int _durationMilSec = 500;
  static const double _borderRadius = 25;
  static const double _tabBarHeight = 28;
  static const double _tabBarWidth = 70;

  // TODO : 버튼 클릭 시 이벤트
  void _handleClickMapButton() {
    print("Click Map Button");
  }

  void _handleClickCartButton() {
    print("Click Cart Button");
  }

  _handleMallType(BuildContext context) =>
      (int index) => context.read<MallTypeCubit>().handleIndex(index);

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<MallTypeCubit, MallTypeState>(
        builder: (BuildContext _, MallTypeState state) {
          final borderRadius = const BorderRadius.all(
            Radius.circular(_borderRadius),
          );
          final colorScheme = Theme.of(context).colorScheme;
          final labelStyle = Theme.of(context).textTheme.labelLarge.bold;
          final unSelectedLabelStyle = Theme.of(context).textTheme.labelLarge;
          final iconColorFilter = ColorFilter.mode(
            state.isMarketMall
                ? colorScheme.background
                : colorScheme.contentPrimary,
            BlendMode.srcIn,
          );
          final logoColorFilter = ColorFilter.mode(
            state.isMarketMall ? colorScheme.onPrimary : colorScheme.primary,
            BlendMode.srcIn,
          );

          final indicatorColor =
              state.isMarketMall ? colorScheme.background : colorScheme.primary;
          final labelColor =
              state.isMarketMall ? colorScheme.primary : colorScheme.onPrimary;

          final unSelectedLabelColor = state.isMarketMall
              ? colorScheme.background
              : colorScheme.contentPrimary;
          final backgroundColor =
              state.isMarketMall ? colorScheme.primary : colorScheme.background;

          return AppBar(
            /// app logo
            leading: Padding(
              padding: const EdgeInsets.only(left: _horizontalPadding),
              child: SvgPicture.asset(
                IconPaths.splashImage,
                colorFilter: logoColorFilter,
              ),
            ),

            /// tab bar
            title: AnimatedContainer(
              decoration: BoxDecoration(borderRadius: borderRadius),
              child: DefaultTabController(
                length: MallTypeState.values.length,
                initialIndex: state.index,
                child: SizedBox(
                  height: _tabBarHeight,
                  child: TabBar(
                      tabs: List.generate(MallTypeState.values.length,
                              (index) => MallTypeState.values[index].mallName)
                          .map((name) => Tab(
                              child: SizedBox(
                                  width: _tabBarWidth,
                                  child: Center(child: Text(name)))))
                          .toList(),
                      isScrollable: true,
                      indicator: BoxDecoration(
                          color: indicatorColor, borderRadius: borderRadius),
                      indicatorSize: TabBarIndicatorSize.tab,
                      dividerColor: Colors.transparent,
                      labelColor: labelColor,
                      labelStyle: labelStyle,
                      labelPadding:
                          EdgeInsets.symmetric(horizontal: _horizontalPadding),
                      unselectedLabelColor: unSelectedLabelColor,
                      unselectedLabelStyle: unSelectedLabelStyle,
                      onTap: _handleMallType(context),
                      splashBorderRadius: borderRadius),
                ),
                animationDuration: Duration(milliseconds: _durationMilSec),
              ),
              duration: Duration(milliseconds: _durationMilSec),
            ),

            /// location, cart icon
            actions: [
              IconButton(
                onPressed: _handleClickMapButton,
                icon: SvgPicture.asset(
                  IconPaths.location,
                  colorFilter: iconColorFilter,
                ),
              ),
              IconButton(
                onPressed: _handleClickCartButton,
                icon: SvgPicture.asset(
                  IconPaths.cart,
                  colorFilter: iconColorFilter,
                ),
              ),
              Width(_horizontalPadding),
            ],
            backgroundColor: backgroundColor,
            centerTitle: true,
          );
        },
      );
}
