import '../../common/utils/common.dart';
import 'components/bottom_nav_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../pages/category/category_page.dart';
import '../pages/home/home_page.dart';
import '../pages/search/search_page.dart';
import '../pages/user/user_page.dart';
import 'components/top_app_bar_widget.dart';
import 'cubit/bottom_nav_cubit.dart';
import 'cubit/top_app_bar_cubit.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => MallTypeCubit()),
          BlocProvider(create: (_) => BottomNavCubit()),
        ],
        child: MainScreenView(),
      );
}

class MainScreenView extends StatelessWidget {
  const MainScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBarWidget(),
      body: BlocBuilder<BottomNavCubit, BottomNav>(
        builder: (BuildContext context, BottomNav state) {
          switch (state) {
            case BottomNav.home:
              return const HomePage();
            case BottomNav.category:
              return const CategoryPage();
            case BottomNav.search:
              return const SearchPage();
            case BottomNav.user:
              return const UserPage();
          }
        },
      ),
      bottomNavigationBar: BottomNavWidget(),
    );
  }
}
