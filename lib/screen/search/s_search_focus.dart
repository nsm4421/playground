import 'package:flutter/material.dart';
import 'package:flutter_sns/screen/c_bottom_nav.dart';
import 'package:flutter_sns/screen/search/f_accounts.dart';
import 'package:flutter_sns/screen/search/f_audio.dart';
import 'package:flutter_sns/screen/search/f_place.dart';
import 'package:flutter_sns/screen/search/f_tag.dart';
import 'package:flutter_sns/screen/search/f_top.dart';
import 'package:flutter_sns/util/common_size.dart';
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
      preferredSize: Size.fromHeight(CommonSize.padding5xl),
      child: Container(
        width: Size.infinite.width,
        height: CommonSize.padding5xl,
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Color(0xffe4e4e4)))),
        child: TabBar(
            indicatorColor: Colors.black,
            controller: tabController,
            tabs: tabMenu
                .map((tab) => Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: CommonSize.paddingMd),
                      child: Text(
                        tab.label,
                        style: TextStyle(
                            fontSize: CommonSize.fontsizeMd,
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
        margin: EdgeInsets.only(top: CommonSize.paddingSm),
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
        padding: EdgeInsets.only(
            left: CommonSize.paddingMd,
            top: CommonSize.paddingSm,
            bottom: CommonSize.paddingSm),
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
      margin: EdgeInsets.only(top: CommonSize.paddingLg),
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
