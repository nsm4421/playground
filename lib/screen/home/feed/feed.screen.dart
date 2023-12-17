import 'package:flutter/material.dart';
import 'package:my_app/core/util/time_diff.util.dart';

import '../../../domain/model/feed/feed.model.dart';

final mockFeeds = <FeedModel>[
  FeedModel(
      fid: 'A',
      commentCount: 23423,
      content: 'test feed A',
      shareCount: 50,
      likeCount: 4324,
      createdAt: DateTime.now()),
  FeedModel(
      fid: 'B',
      commentCount: 324,
      content: 'test feed B',
      shareCount: 432,
      likeCount: 4324,
      createdAt: DateTime.now()),
  FeedModel(
      fid: 'C',
      commentCount: 2342,
      content: 'test feed C',
      shareCount: 23,
      likeCount: 13240,
      createdAt: DateTime.now()),
  FeedModel(
      fid: 'D',
      commentCount: 2020,
      content: 'test feed D',
      shareCount: 100,
      likeCount: 300,
      createdAt: DateTime.now()),
];

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Feed"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: mockFeeds.length,
                  itemBuilder: (context, index) => _FeedItem(mockFeeds[index])),
            ],
          ),
        ),
      );
}

class _FeedItem extends StatelessWidget {
  const _FeedItem(this.feed, {super.key});

  final FeedModel feed;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const SizedBox(width: 40, child: CircleAvatar()),
                const SizedBox(width: 8),
                Text(feed.uid ?? "nickname"),
                const SizedBox(width: 5),
                if (feed.createdAt != null)
                  Text(TimeDiffUtil.getTimeDiffRep(feed.createdAt!)),
                Spacer(),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.more_horiz_rounded))
              ],
            ),
            const SizedBox(height: 10),
            const Row(
              children: [
                SizedBox(width: 50),
                Text("~~~~"),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 40),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.favorite_outline,
                      color: Theme.of(context).colorScheme.secondary,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.chat_bubble_outline,
                        color: Theme.of(context).colorScheme.secondary)),
                IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.repeat,
                        color: Theme.of(context).colorScheme.secondary)),
                IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.send,
                        color: Theme.of(context).colorScheme.secondary)),
              ],
            ),
            const SizedBox(height: 5),
            const Divider(indent: 18, endIndent: 18, thickness: 0.5),
            const SizedBox(height: 5),
          ],
        ),
      );
}
