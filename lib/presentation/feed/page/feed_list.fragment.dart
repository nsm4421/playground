import 'package:flutter/material.dart';
import 'package:hot_place/core/di/dependency_injection.dart';
import 'package:hot_place/domain/usecase/feed/feed.usecase.dart';

import 'package:hot_place/presentation/feed/widget/feed_item.widget.dart';

import '../../../data/entity/feed/base/feed.entity.dart';

class FeedListFragment extends StatefulWidget {
  const FeedListFragment({super.key});

  @override
  State<FeedListFragment> createState() => _FeedListFragmentState();
}

class _FeedListFragmentState extends State<FeedListFragment> {
  Stream<List<FeedEntity>>? _feedStream;

  @override
  void initState() {
    super.initState();
    _feedStream = getIt<FeedUseCase>().feedStream();
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: StreamBuilder(
            stream: _feedStream,
            builder: (_, snapshot) {
              // 로딩중
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: const Center(child: CircularProgressIndicator()));
              }
              // 오류
              else if (!snapshot.hasData || snapshot.hasError) {
                return Center(
                    child: Text("ERROR",
                        style: Theme.of(context).textTheme.displayMedium));
              }
              // 정상적으로 데이터 불러온 경우
              else {
                final feeds = snapshot.data!;
                return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: feeds.length,
                    itemBuilder: (_, index) => FeedItemWidget(feeds[index]));
              }
            }),
      );
}
