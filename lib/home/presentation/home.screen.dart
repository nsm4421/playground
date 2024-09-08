part of 'home.page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen(this._navigationShell, {super.key});

  final StatefulNavigationShell _navigationShell;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget._navigationShell,
      bottomNavigationBar: BottomNavigationFragment(widget._navigationShell),
    );
  }
}
