part of 'index.page.dart';

class BottomNavigationFragment extends StatefulWidget {
  const BottomNavigationFragment(this._navigationShell, {super.key});

  final StatefulNavigationShell _navigationShell;

  @override
  State<BottomNavigationFragment> createState() =>
      _BottomNavigationFragmentState();
}

class _BottomNavigationFragmentState extends State<BottomNavigationFragment> {
  _onTap(int idx) {
    if (idx != widget._navigationShell.currentIndex) {
      widget._navigationShell.goBranch(
        idx,
        initialLocation: idx == widget._navigationShell.currentIndex,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        elevation: 0,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        currentIndex: widget._navigationShell.currentIndex,
        onTap: _onTap,
        items: HomeBottomNavItems.values
            .map((item) => BottomNavigationBarItem(
                activeIcon: Icon(item.activeIconData, size: 25),
                icon: Icon(item.iconData, size: 20),
                label: item.label))
            .toList());
  }
}
