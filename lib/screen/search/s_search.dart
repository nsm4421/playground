import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sns/screen/search/s_search_focus.dart';
import 'package:get/get.dart';
import 'package:quiver/iterables.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  static const double _IMAGE_PADDING = 2;
  static const double _SMALL_PADDING = 8;
  static const double _LARGE_PADDING = 15;
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
            onTap: (){Get.to(SearchFocusScreen());},
            child: Container(
              padding: const EdgeInsets.symmetric(
                  vertical: SearchScreen._SMALL_PADDING,
                  horizontal: SearchScreen._SMALL_PADDING),
              margin: const EdgeInsets.symmetric(
                  vertical: SearchScreen._SMALL_PADDING,
                  horizontal: SearchScreen._LARGE_PADDING),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: const Color(0xefefefef),
              ),
              child: const Row(
                children: [
                  Icon(Icons.search),
                  Text(
                    "Search",
                    style: TextStyle(fontSize: 15, color: Color(0xef838383)),
                  ),
                ],
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(right: SearchScreen._LARGE_PADDING),
          child: Icon(Icons.location_pin),
        )
      ],
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
            groupedBox.length,
            (idx1) => Expanded(
                    child: Column(
                  children: List.generate(
                      groupedBox[idx1].length,
                      (idx2) => Container(
                            padding: const EdgeInsets.all(
                                SearchScreen._IMAGE_PADDING),
                            height: Get.width / 3 * groupedBox[idx1][idx2],
                            child: CachedNetworkImage(
                              imageUrl: SearchScreen._MOCK_IMAGE,
                              fit: BoxFit.cover,
                            ),
                          )),
                ))).toList(),
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
            Expanded(child: _body()),
          ],
        ),
      ),
    );
  }
}
