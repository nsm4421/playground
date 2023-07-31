import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sns/screen/search/s_search_focus.dart';
import 'package:flutter_sns/util/common_size.dart';
import 'package:get/get.dart';
import 'package:quiver/iterables.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  static const String _MOCK_IMAGE = 'https://picsum.photos/250/250';
  static const int _MOCK_IMAGE_COUNT = 100;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<List<int>> groupedBox = [[], [], []];
  List<int> groupedIndex = [0, 0, 0];

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < SearchScreen._MOCK_IMAGE_COUNT; i++) {
      var idx = groupedIndex.indexOf(min<int>(groupedIndex)!);
      var size = 1;
      if (idx != 1) {
        size =
            Random().nextInt(SearchScreen._MOCK_IMAGE_COUNT) % 2 == 0 ? 1 : 2;
      }
      groupedBox[idx].add(size);
      groupedIndex[idx] += size;
    }
  }

  Widget _appBar() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (ctx) => SearchFocusScreen()));
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: CommonSize.paddingMd,
                  horizontal: CommonSize.paddingSm),
              margin: EdgeInsets.only(
                  left: CommonSize.paddingTiny,
                  right: CommonSize.paddingTiny,
                  bottom: CommonSize.paddingLg),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: const Color(0xefefefef),
              ),
              child: Row(
                children: [
                  Icon(Icons.search),
                  SizedBox(
                    width: CommonSize.paddingTiny,
                  ),
                  Text(
                    "Search",
                    style: TextStyle(
                        fontSize: CommonSize.fontsizeMd,
                        color: Color(0xef838383)),
                  ),
                ],
              ),
            ),
          ),
        ),
        // TODO : location 버튼 누를 때 동작 정의
        GestureDetector(
          onTap: () {},
          child: Padding(
            padding: EdgeInsets.only(
                left: CommonSize.paddingLg,
                right: CommonSize.paddingLg,
                bottom: CommonSize.paddingLg),
            child: Icon(Icons.location_pin),
          ),
        )
      ],
    );
  }

  Widget _body() {
    return Expanded(
      child: SingleChildScrollView(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
              groupedBox.length,
              (idx1) => Expanded(
                      child: Column(
                    children: List.generate(
                        groupedBox[idx1].length,
                        (idx2) => Container(
                              padding: EdgeInsets.all(CommonSize.paddingTiny),
                              height: Get.width / 3 * groupedBox[idx1][idx2],
                              child: CachedNetworkImage(
                                imageUrl: SearchScreen._MOCK_IMAGE,
                                fit: BoxFit.cover,
                              ),
                            )),
                  ))).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _appBar(),
            _body(),
          ],
        ),
      ),
    );
  }
}
