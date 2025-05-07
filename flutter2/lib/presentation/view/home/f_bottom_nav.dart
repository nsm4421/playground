part of 'index.dart';

class BottomNavigationFragment extends StatelessWidget with CustomLogger {
  BottomNavigationFragment(this._navigationShell, {super.key});

  final StatefulNavigationShell _navigationShell;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBottomNavCubit, HomeBottomNavState>(
      builder: (context, state) {
        return (state.visible)
            ? BottomNavigationBar(
                elevation: 0,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: context.colorScheme.primary,
                unselectedItemColor: context.colorScheme.shadow,
                showSelectedLabels: true,
                showUnselectedLabels: false,
                currentIndex: _navigationShell.currentIndex,
                onTap: (int idx) {
                  if (idx != _navigationShell.currentIndex) {
                    logger.d(
                        'idx:$idx|current index:${_navigationShell.currentIndex}');
                    _navigationShell.goBranch(
                      idx,
                      initialLocation: idx == _navigationShell.currentIndex,
                    );
                    context.read<HomeBottomNavCubit>().handleIndex(idx);
                  }
                },
                items: HomeBottomNavItem.values
                    .map((item) => BottomNavigationBarItem(
                        activeIcon:
                            Icon(item.activeIcon, size: item.activeIconSize),
                        icon: Icon(item.icon, size: item.iconSize),
                        label: item.label))
                    .toList())
            : const SizedBox();
      },
    );
  }
}
