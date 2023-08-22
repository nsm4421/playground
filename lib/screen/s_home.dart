import 'package:chat_app/common/widget/w_size.dart';
import 'package:chat_app/screen/call/s_call.dart';
import 'package:chat_app/screen/chat/s_chat.dart';
import 'package:chat_app/screen/status/s_status.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // TODO : 아이콘 클릭 이벤트
  void _handleClickMoreIcon() {}

  void _handleClickSearchIcon() {}

  @override
  Widget build(BuildContext context) {
    const double appBarTextSize = 25;
    const double paddingSizeTn = 5;
    const double appBarIconSize = 25;
    const double fontSizeMd = 18;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text(
            "HOME",
            style: GoogleFonts.lobster(
              fontSize: appBarTextSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            Row(
              children: [
                /// 검색 아이콘
                InkWell(
                  onTap: () {
                    _handleClickSearchIcon();
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(paddingSizeTn),
                    child: Icon(
                      Icons.search,
                      size: appBarIconSize,
                    ),
                  ),
                ),
                const Width(width: paddingSizeTn),

                /// 더보기 아이콘
                InkWell(
                  onTap: () {
                    _handleClickMoreIcon();
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(paddingSizeTn),
                    child: Icon(
                      Icons.more_horiz,
                      size: appBarIconSize,
                    ),
                  ),
                ),
                const Width(width: paddingSizeTn)
              ],
            )
          ],

          /// 탭 메뉴
          bottom: const TabBar(
            indicatorPadding: EdgeInsets.all(3),
            labelStyle: TextStyle(
              fontSize: fontSizeMd,
              fontWeight: FontWeight.bold,
            ),
            tabs: [
              Tab(text: "Chat"),
              Tab(text: "Status"),
              Tab(text: "Call"),
            ],
          ),
        ),

        /// 탭 뷰
        body: const TabBarView(
          children: [
            ChatScreen(),
            StatusScreen(),
            CallScreen(),
          ],
        ),
      ),
    );
  }
}
