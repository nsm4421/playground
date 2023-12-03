import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/domain/model/feed/feed.model.dart';
import 'package:my_app/presentation/pages/feed/bloc/feed.bloc.dart';
import 'package:my_app/presentation/pages/feed/bloc/feed.event.dart';
import 'component/feed_item.widget.dart';

class FeedListFragment extends StatefulWidget {
  const FeedListFragment({super.key});

  @override
  State<FeedListFragment> createState() => _FeedListFragmentState();
}

class _FeedListFragmentState extends State<FeedListFragment> {
  late ScrollController _sc;

  @override
  initState() {
    super.initState();
    _sc = ScrollController();
    if (context.read<FeedBloc>().state.feedStream == null) {
      context.read<FeedBloc>().add(FeedInitializedEvent());
    }
  }

  @override
  dispose() {
    super.dispose();
    _sc.dispose();
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        controller: _sc,
        child: StreamBuilder<List<FeedModel>>(
          stream: context.read<FeedBloc>().state.feedStream,
          initialData: context.read<FeedBloc>().state.feeds,
          builder: (_, AsyncSnapshot<List<FeedModel>> snapshot) {
            // 로딩중
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            // 데이터 가져오기 실패
            if (snapshot.data == null) return const Text("NO DATA");
            // Feed 목록
            return Column(
                children:
                    snapshot.data!.map((e) => FeedItemWidget(e)).toList());
          },
        ),
      );
}
