import 'package:chat_app/controller/feed_controller.dart';
import 'package:chat_app/model/feed_model.dart';
import 'package:chat_app/screen/service/feed/s_add_feed.dart';
import 'package:chat_app/screen/service/feed/s_search_feed.dart';
import 'package:chat_app/screen/widget/w_box.dart';
import 'package:chat_app/screen/widget/w_feed_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class FeedScreen extends ConsumerStatefulWidget {
  const FeedScreen({super.key});

  @override
  ConsumerState<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends ConsumerState<FeedScreen> {
  @override
  void initState() {
    super.initState();
    _fetchFeeds();
  }

  _fetchFeeds() async {
    await ref.read(feedControllerProvider).fetchFeeds(context: context);
    setState(() {});
  }

  _goToAddFeedPage() =>
      ref.read(feedControllerProvider).goToAddFeedPage(context: context);

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
              _goToAddFeedPage();
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
      itemCount: ref.read(feedControllerProvider).feeds.length,
      shrinkWrap: true,
      itemBuilder: (context, index) => Column(
        children: [
          FeedItemWidget(
            feedModel: ref.read(feedControllerProvider).feeds[index],
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
        body: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              _fetchFeeds();
            });
          },
          child: Container(
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
      ),
    );
  }
}
