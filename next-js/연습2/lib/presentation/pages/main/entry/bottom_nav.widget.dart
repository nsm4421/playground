part of "entry.page.dart";

class BottomNavWidget extends StatelessWidget {
  const BottomNavWidget(this.item, {super.key});

  final BottomNav item;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: context.read<BottomNavCubit>().handleIndex,
      currentIndex: item.index,
      type: BottomNavigationBarType.fixed,
      items: BottomNav.values
          .map((e) => BottomNavigationBarItem(
              label: e.label,
              icon: Icon(e.iconData),
              activeIcon: Icon(e.activeIconData)))
          .toList(),
    );
  }
}
