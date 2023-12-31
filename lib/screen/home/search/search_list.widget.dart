import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../api/user/user.api.dart';
import '../../../configurations.dart';
import '../../../core/constant/feed.enum.dart';
import '../../../domain/model/feed/feed.model.dart';
import '../../../domain/model/user/user.model.dart';
import '../../../repository/chat/chat.repository.dart';
import '../../component/feed_item.widget.dart';
import '../chat/chat_room.screen.dart';
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

class _UserListWidget extends StatelessWidget {
  const _UserListWidget(this.users, {super.key});

  final List<UserModel> users;

  _handleSendDirectMessage(
          {required String uid, required BuildContext context}) =>
      () async => await getIt<ChatRepository>()
          .getDirectMessageChatId(uid)
          .then((res) => res.data)
          .then((chatId) => chatId == null
              ? ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("can't send direct message..."),
                  duration: Duration(seconds: 1),
                ))
              : Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          ChatRoomScreen(chatId))));

  @override
  Widget build(BuildContext context) {
    final currentUid = getIt<UserApi>().currentUid;
    return users.isNotEmpty
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return ListTile(
                  // TODO : 클릭 시 개인 페이지로
                  onTap: () {},
                  leading: CircleAvatar(
                    child: user.profileImageUrls.isNotEmpty
                        ? Image.network(user.profileImageUrls[0])
                        : const Icon(Icons.question_mark),
                  ),
                  title: Text(user.nickname ?? ''),
                  trailing: currentUid != user.uid
                      ? IconButton(
                          onPressed: _handleSendDirectMessage(
                              uid: user.uid!, context: context),
                          icon: Icon(
                            Icons.send,
                            color: Theme.of(context).colorScheme.primary,
                          ))
                      : const SizedBox());
            })
        : const Center(child: Text('Nothing Searched'));
  }
}
