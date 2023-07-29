import 'package:flutter/material.dart';
import 'package:flutter_sns/screen/c_bottom_nav.dart';
import 'package:flutter_sns/screen/search/f_accounts.dart';
import 'package:flutter_sns/screen/search/f_audio.dart';
import 'package:flutter_sns/screen/search/f_place.dart';
import 'package:flutter_sns/screen/search/f_tag.dart';
import 'package:flutter_sns/screen/search/f_top.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class TabMenu {
  final String label;
  final Widget fragment;

  TabMenu(this.label, this.fragment);
}

// SearchScreen에서 검색 탭이 focus될 때 보여줄 화면
class SearchFocusScreen extends StatefulWidget {
  const SearchFocusScreen({super.key});

  // static const List<String> tabMenu = ["인기", "계정", "오디오", "태그", "장소"];

  static const double _LARGE_MARGIN = 15;
  static const double _MIDIUM_PADDING = 8;
  static const double _SMALL_PADDING = 2;
  static const double _NAV_HEIGHT = 50;
  static const double _TAB_LABEL_SIZE = 15;

  @override
  State<SearchFocusScreen> createState() => _SearchFocusScreenState();
}

class _SearchFocusScreenState extends State<SearchFocusScreen>
    with TickerProviderStateMixin {
  late TabController tabController;
  final List<TabMenu> tabMenu = [
    TabMenu("인기", TopFragment()),
    TabMenu("계정", AccountFragment()),
    TabMenu("오디오", AudioFragment()),
    TabMenu("태그", TagFragment()),
    TabMenu("장소", PlaceFragment()),
  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);
  }

  PreferredSizeWidget _tabs() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(SearchFocusScreen._NAV_HEIGHT),
      child: Container(
        width: Size.infinite.width,
        height: SearchFocusScreen._NAV_HEIGHT,
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Color(0xffe4e4e4)))),
        child: TabBar(
            indicatorColor: Colors.black,
            controller: tabController,
            tabs: tabMenu
                .map((tab) => Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: SearchFocusScreen._MIDIUM_PADDING),
                      child: Text(
                        tab.label,
                        style: const TextStyle(
                            fontSize: SearchFocusScreen._TAB_LABEL_SIZE,
                            fontWeight: FontWeight.bold),
                      ),
                    ))
                .toList()),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      elevation: 0,
      leading: Container(
        margin: const EdgeInsets.only(top: SearchFocusScreen._LARGE_MARGIN),
        child: GestureDetector(
          onTap: BottomNavController.to.handleWillPop,
          child: const Icon(Icons.arrow_back),
        ),
      ),
      titleSpacing: 0,
      title: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xefefefef)),
        padding: const EdgeInsets.only(
            left: SearchFocusScreen._MIDIUM_PADDING,
            top: SearchFocusScreen._SMALL_PADDING,
            bottom: SearchFocusScreen._SMALL_PADDING),
        margin: const EdgeInsets.only(top: SearchFocusScreen._LARGE_MARGIN),
        child: const TextField(
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Search",
              hintStyle:
                  TextStyle(color: Colors.grey, fontWeight: FontWeight.w500)),
        ),
      ),
      bottom: _tabs(),
    );
  }

  Widget _body() {
    return Container(
      child: TabBarView(
        controller: tabController,
        children: tabMenu.map((tab) => tab.fragment).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }
}
