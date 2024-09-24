part of 'setting.page.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  late ScrollController _nestedScrollController;

  @override
  void initState() {
    super.initState();
    _nestedScrollController = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    _nestedScrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SETTING"),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [UserProfileFragment(), Text('test')],
        ),
      ),
    );
  }
}
