import 'package:chat_app/model/feed_model.dart';
import 'package:chat_app/screen/service/feed/s_add_feed.dart';
import 'package:chat_app/screen/service/feed/s_search_feed.dart';
import 'package:chat_app/screen/widget/w_box.dart';
import 'package:chat_app/screen/widget/w_feed_item.dart';
import 'package:chat_app/utils/alert_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  late FirebaseFirestore _db;
  List<FeedModel> _feeds = [];

  @override
  void initState() {
    super.initState();
    _db = FirebaseFirestore.instance;
    _fetchFeeds();
  }

  Future _fetchFeeds() async {
    try {
      await _db.collection("feeds").get().then((res) => res.docs).then((docs) {
        for (var doc in docs) {
          _feeds.add(FeedModel.fromJson(doc.data()));
        }
      });
      setState(() {});
    } catch (e) {
      AlertUtils.showSnackBar(context, 'Fetching Fails...');
    }
  }

  AppBar _appBar(BuildContext context) => AppBar(
        elevation: 0,
        centerTitle: true,
        title: Column(
          children: [
            Text(
              "Feed",
              style: GoogleFonts.lobster(
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              // go to add page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddFeedScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.add,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: () {
              // go to search page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchFeedScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.search_rounded,
              size: 30,
            ),
          )
        ],
      );

  Widget _feedListView() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      // single child scroll view 내부에서 list view를 사용하는 경우 해당 옵션을 주어야 스크롤 가능
      itemCount: _feeds.length,
      shrinkWrap: true,
      itemBuilder: (context, index) => Column(
        children: [
          FeedItemWidget(
            feedModel: _feeds[index],
          ),
          const Height(20),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _appBar(context),
        body: Container(
          padding: const EdgeInsets.only(
            top: 5,
            left: 10,
            right: 10,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Height(40),
                _feedListView(),
                const Height(50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
