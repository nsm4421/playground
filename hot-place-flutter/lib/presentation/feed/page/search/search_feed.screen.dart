import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hot_place/core/di/dependency_injection.dart';
import 'package:hot_place/presentation/feed/bloc/base/feed.bloc.dart';
import 'package:hot_place/presentation/feed/page/search/not_search_yet.widget.dart';
import 'package:hot_place/presentation/feed/page/search/searched.widget.dart';
import 'package:hot_place/presentation/feed/widget/feed_error.widget.dart';

class SearchFeedScreen extends StatefulWidget {
  const SearchFeedScreen({super.key});

  @override
  State<SearchFeedScreen> createState() => _SearchFeedScreenState();
}

class _SearchFeedScreenState extends State<SearchFeedScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => getIt<FeedBloc>()..add(InitFeedEvent()),
        child: BlocBuilder<FeedBloc, FeedState>(builder: (_, state) {
          if (state is InitialFeedState) {
            // 검색 화면
            return const NotSearchedYetWidget();
          } else if (state is SearchFeedSuccessState) {
            // 검색 조회 결과
            return SearchedWidget(hashtag: state.hashtag, feeds: state.feeds);
          } else if (state is FeedLoadingState) {
            // 로딩중
            return const Center(child: CircularProgressIndicator());
          } else if (state is FeedFailureState) {
            // 오류
            return FeedErrorWidget(state.message);
          } else {
            return const FeedErrorWidget('알수 없는 오류가 발생했습니다');
          }
        }));
  }
}
