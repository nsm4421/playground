import 'package:flutter/material.dart';
import 'package:my_app/api/user/user.api.dart';

import '../../api/feed/feed.api.dart';
import '../../configurations.dart';
import '../../domain/model/feed/feed.model.dart';
import 'feed_item.widget.dart';

class FeedFragment extends StatefulWidget {
  const FeedFragment({super.key, this.isMyFeed = false});

  final bool isMyFeed;

  @override
  State<FeedFragment> createState() => _FeedFragmentState();
}

class _FeedFragmentState extends State<FeedFragment> {
  late String _currentUid;

  @override
  void initState() {
    super.initState();
    _currentUid = getIt<UserApi>().currentUid!;
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<List<FeedModel>>(
        stream: getIt<FeedApi>()
            .getFeedStreamByUser(uid: widget.isMyFeed ? _currentUid : null),
        builder: (_, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            case ConnectionState.done:
            case ConnectionState.active:
              return (snapshot.hasData && !snapshot.hasError)
                  ? Scaffold(
                      body: SingleChildScrollView(
                        child: Column(
                          children: [
                            ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) =>
                                    FeedItemWidget(snapshot.data![index])),
                          ],
                        ),
                      ),
                    )
                  // TODO : 에러처리
                  : const Text("ERROR");
          }
        },
      );
}
