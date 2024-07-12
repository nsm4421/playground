import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hot_place/presentation/feed/bloc/base/feed.bloc.dart';
import 'package:hot_place/presentation/feed/widget/feed_item.widget.dart';

import '../../../../data/entity/feed/base/feed.entity.dart';

class SearchedWidget extends StatefulWidget {
  const SearchedWidget({super.key, required this.hashtag, required this.feeds});

  final String hashtag;
  final List<FeedEntity> feeds;

  @override
  State<SearchedWidget> createState() => _SearchedState();
}

class _SearchedState extends State<SearchedWidget> {
  _handleInitSearch() {
    context.read<FeedBloc>().add(InitFeedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(actions: [
          IconButton(
              onPressed: _handleInitSearch, icon: const Icon(Icons.refresh))
        ]),
        body: widget.feeds.isNotEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: widget.hashtag,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.primary)),
                      TextSpan(
                          text: ' 라는 검색어로 ',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary)),
                      TextSpan(
                          text: '${widget.feeds.length}',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.primary)),
                      TextSpan(
                          text: '개의 게시글이 조회 되었습니다',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary))
                    ])),
                  ),
                  Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: widget.feeds.length,
                        itemBuilder: (_, index) {
                          return FeedItemWidget(widget.feeds[index]);
                        }),
                  ),
                ],
              )
            : Center(
                child: Text('조회된 결과가 없습니다 ㅠㅠ',
                    style: Theme.of(context).textTheme.headlineSmall)));
  }
}
