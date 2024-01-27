import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../api/user/user.api.dart';
import '../../../configurations.dart';
import '../../../core/constant/feed.enum.dart';
import '../../../domain/model/feed/feed.model.dart';
import '../../../domain/model/user/user.model.dart';
import '../../component/feed_item.widget.dart';
import '../../component/user_item.widget.dart';
import 'bloc/search.bloc.dart';
import 'bloc/search.state.dart';

class SearchListWidget extends StatelessWidget {
  const SearchListWidget({super.key});

  @override
  Widget build(BuildContext context) => Expanded(
        child: BlocBuilder<SearchBloc, SearchState>(
          builder: (_, state) {
            switch (state.status) {
              case SearchStatus.initial:
                return const Center(child: Text("not search yet"));
              case SearchStatus.loading:
                return const Center(child: CircularProgressIndicator());
              case SearchStatus.success:
                return context.read<SearchBloc>().state.option ==
                        SearchOption.nickname
                    ? _UserListWidget(context.read<SearchBloc>().state.users)
                    : _FeedListWidget(context.read<SearchBloc>().state.feeds);
              case SearchStatus.error:
                return const Text("Search Error");
            }
          },
        ),
      );
}

class _FeedListWidget extends StatelessWidget {
  const _FeedListWidget(this.feeds, {super.key});

  final List<FeedModel> feeds;

  @override
  Widget build(BuildContext context) => feeds.isNotEmpty
      ? ListView.builder(
          shrinkWrap: true,
          itemCount: feeds.length,
          itemBuilder: (context, index) => FeedItemWidget(feeds[index]))
      : const Center(child: Text('Nothing Searched'));
}

class _UserListWidget extends StatefulWidget {
  const _UserListWidget(this.users);

  final List<UserModel> users;

  @override
  State<_UserListWidget> createState() => _UserListWidgetState();
}

class _UserListWidgetState extends State<_UserListWidget> {
  late Stream<List<UserModel>> _stream;
  late String _currentUid;

  @override
  void initState() {
    super.initState();
    _stream = getIt<UserApi>().getFollowingStream();
    _currentUid = getIt<UserApi>().currentUid!;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<UserModel>>(
        stream: _stream,
        builder: (_, snapshot) {
          final followingUidList = (snapshot.data ?? []).map((e) => e.uid);
          return widget.users.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.users.length,
                  itemBuilder: (_, index) {
                    final user = widget.users[index];
                    final isFollowing = followingUidList.contains(user.uid);
                    return UserItemWidget(
                      currentUid: _currentUid,
                      user: user,
                      addFollowButton: !isFollowing,
                      addUnFollowButton: isFollowing,
                    );
                  })
              : const Center(child: Text('Nothing Searched'));
        });
  }
}
