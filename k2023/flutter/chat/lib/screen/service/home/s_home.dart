import 'package:chat_app/screen/widget/w_box.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeFragment extends StatefulWidget {
  const HomeFragment({super.key});

  @override
  State<HomeFragment> createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  int _bannerIndex = 0;
  final PageController _pageController = PageController();

  _handleLogout() => FirebaseAuth.instance.signOut();

  AppBar _appBar() => AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Chat App",
          style: GoogleFonts.lobsterTwo(
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _handleLogout,
            icon: const Icon(
              Icons.logout,
              size: 25,
              color: Colors.blueGrey,
            ),
          ),
        ],
      );

  Widget _banner() {
    const double bannerHeight = 200;
    // TODO : Change Banners
    final banners = [
      Container(color: Colors.red),
      Container(color: Colors.blue),
      Container(color: Colors.green),
    ];
    return Column(
      children: [
        SizedBox(
          height: bannerHeight,
          child: PageView(
            scrollDirection: Axis.horizontal,
            controller: _pageController,
            children: banners,
            onPageChanged: (idx) {
              setState(() {
                _bannerIndex = idx;
              });
            },
          ),
        ),
        const Height(20),
        DotsIndicator(
          dotsCount: banners.length,
          position: _bannerIndex,
        ),
      ],
    );
  }

  /// 회원 추천하기
  Widget _recommend() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Recommend",
                  style: GoogleFonts.lobster(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                Text(
                  "More",
                  style: GoogleFonts.lobster(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            const Height(20),
            Container(
              height: 300,
              color: Colors.blueGrey,
            ),
          ],
        ),
      );

  /// 가장 인기 많은 회원
  Widget _star() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Star",
                  style: GoogleFonts.lobster(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                Text(
                  "More",
                  style: GoogleFonts.lobster(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            const Height(20),
            Container(
              height: 300,
              color: Colors.blueGrey,
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _appBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _banner(),
              const DefaultDivider(),
              _recommend(),
              const DefaultDivider(),
              _star(),
              const Height(50)
            ],
          ),
        ),
      ),
    );
  }
}
