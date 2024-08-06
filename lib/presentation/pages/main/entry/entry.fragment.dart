part of "entry.page.dart";

class EntryFragment extends StatelessWidget {
  const EntryFragment(this.item, {super.key});

  final BottomNav item;

  @override
  Widget build(BuildContext context) {
    switch (item) {
      case BottomNav.home:
        return const DisplayFeedPage();
      case BottomNav.chat:
        return const DisplayPrivateChatPage();
      case BottomNav.setting:
        return const SettingPage();
    }
  }
}
