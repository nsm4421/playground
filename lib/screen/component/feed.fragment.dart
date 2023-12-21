import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api/feed/feed.api.dart';
import '../../configurations.dart';
import '../../domain/model/feed/feed.model.dart';
import '../home/bloc/auth.bloc.dart';
import 'feed_item.widget.dart';

class FeedFragment extends StatelessWidget {
  const FeedFragment({super.key, this.isMyFeed = false});

  final bool isMyFeed;

  @override
  Widget build(BuildContext context) => StreamBuilder<List<FeedModel>>(
        stream: getIt<FeedApi>().getFeedStreamByUser(
            uid: isMyFeed ? context.read<AuthBloc>().state.uid : null),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            case ConnectionState.done:
            case ConnectionState.active:
              return (snapshot.hasData && !snapshot.hasError)
                  ? Scaffold(
                      body: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                      ),
                    )
                  // TODO : 에러처리
                  : const Text("ERROR");
          }
        },
      );
}
