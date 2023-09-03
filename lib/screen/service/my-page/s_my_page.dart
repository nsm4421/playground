import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyPageScreen extends StatefulWidget {
  const MyPageScreen({super.key});

  @override
  State<MyPageScreen> createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: 0,
      animationDuration: const Duration(
        microseconds: 800,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  Widget _tabBar() => TabBar(
        labelColor: Colors.blueAccent,
        unselectedLabelColor: Colors.blueGrey,
        indicatorColor: Colors.teal,
        indicatorWeight: 1,
        indicatorSize: TabBarIndicatorSize.tab,
        tabs: const [
          Tab(
            text: "Friends",
            icon: Icon(Icons.person),
          ),
          Tab(
            text: "Notification",
            icon: Icon(Icons.notifications),
          ),
          Tab(
            text: "Setting",
            icon: Icon(Icons.settings),
          ),
        ],
        controller: _tabController,
      );

  Widget _tabView() => TabBarView(
        controller: _tabController,
        children: const [
          Text("Friends"),
          Text("Notifications"),
          Text("Setting"),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            _tabBar(),
            Expanded(
              child: _tabView(),
            )
          ],
        ),
      ),
    );
  }
}
