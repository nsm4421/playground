import 'package:chat_app/screen/widget/w_box.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchFragment extends StatefulWidget {
  const SearchFragment({super.key});

  @override
  State<SearchFragment> createState() => _SearchFragmentState();
}

class _SearchFragmentState extends State<SearchFragment> {
  AppBar _appBar() => AppBar(
        elevation: 0,
        centerTitle: true,
        title: Column(
          children: [
            Text(
              "Search",
              style: GoogleFonts.lobster(
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
            ),
          ],
        ),
      );

  Widget _searchBar() => Column(
        children: [
          Row(
            children: [
              const Expanded(
                child: SearchBar(),
              ),
              const Width(5),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.filter_alt_rounded,
                  size: 30,
                ),
              ),
              const Width(3),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search_rounded,
                  size: 30,
                ),
              )
            ],
          )
        ],
      );

  Widget _listView() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      // single child scroll view 내부에서 list view를 사용하는 경우 해당 옵션을 주어야 스크롤 가능
      itemCount: 10,
      shrinkWrap: true,
      itemBuilder: (context, index) => Container(
        height: 150,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  child: Container(),
                ),
                Width(10),
                Text(
                  "USER ID",
                  style: GoogleFonts.karla(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Expanded(
              child: Text("Message"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.thumb_up_alt_outlined)),
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.message_outlined)),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _appBar(),
        body: Container(
          padding: const EdgeInsets.only(
            top: 5,
            left: 10,
            right: 10,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Height(30),
                _searchBar(),
                const Height(40),
                _listView(),
                const Height(50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
