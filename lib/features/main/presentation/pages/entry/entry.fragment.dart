part of "entry.page.dart";

class EntryFragment extends StatelessWidget {
  const EntryFragment(this.item, {super.key});

  final BottomNav item;

  @override
  Widget build(BuildContext context) {
    switch (item) {
      // TODO : UI 구현하기
      case BottomNav.home:
        return const Text("HOME");
      case BottomNav.chat:
        return const ChatPage();
      case BottomNav.setting:
        return const Text("SETTING");
    }
  }
}
