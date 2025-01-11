part of '../export.pages.dart';

class HomePage extends StatelessWidget {
  const HomePage(this._navigationShell, {super.key});

  final StatefulNavigationShell _navigationShell;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => getIt<HomeBottomNavCubit>(param1: _navigationShell),
        child: BlocBuilder<HomeBottomNavCubit, HomeBottomNavState>(
          builder: (context, state) {
            return Scaffold(
              body: _navigationShell,
              bottomNavigationBar: state.isVisible
                  ? BottomNavigationBar(
                      onTap: context.read<HomeBottomNavCubit>().handleIndex,
                      currentIndex: state.item.index,
                      elevation: 0,
                      showSelectedLabels: true,
                      showUnselectedLabels: false,
                      items: HomeBottomNavItems.values
                          .map(
                            (item) => BottomNavigationBarItem(
                              label: item.label,
                              icon: Icon(item.iconData),
                              activeIcon: Icon(item.activeIconData),
                            ),
                          )
                          .toList(),
                    )
                  : const SizedBox.shrink(),
            );
          },
        ));
  }
}
