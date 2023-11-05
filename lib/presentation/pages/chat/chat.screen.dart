import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/core/theme/custom_theme.dart';
import 'package:my_app/presentation/pages/chat/bloc/chat_room/chat_room.bloc.dart';
import 'package:my_app/presentation/pages/chat/bloc/chat_room/chat_room.event.dart';
import 'package:my_app/presentation/pages/chat/bloc/chat_room/chat_room.state.dart';
import 'package:my_app/presentation/pages/chat/chat_room.screen.dart';
import 'package:my_app/presentation/pages/chat/create_chat_room.screen.dart';

import '../../../core/constant/asset_path.dart';
import '../../../core/constant/enums/status.enum.dart';
import '../../../dependency_injection.dart';
import '../../../domain/model/chat/chat_room/chat_room.model.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
      create: (BuildContext context) =>
          getIt<ChatRoomBloc>()..add(ChatRoomInitializedEvent()),
      child: BlocBuilder<ChatRoomBloc, ChatRoomState>(builder: (_, state) {
        switch (state.status) {
          case Status.initial:
          case Status.loading:
          case Status.error:
            return const Center(child: CircularProgressIndicator());
          case Status.success:
            return _ChatScreenView(state);
        }
      }));
}

class _ChatScreenView extends StatefulWidget {
  const _ChatScreenView(this.state, {super.key});

  final ChatRoomState state;

  @override
  State<_ChatScreenView> createState() => _ChatScreenViewState();
}

class _ChatScreenViewState extends State<_ChatScreenView> {
  _handleShowCreateChatRoomDialog() => showModalBottomSheet(
      context: context,
      elevation: 0,
      isScrollControlled: true,
      builder: (BuildContext context) => const CreateChatRoomScreen());

  _handleGetChatRooms() {
    context.read<ChatRoomBloc>().add(ChatRoomInitializedEvent());
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("CHAT"),
          actions: [
            IconButton(
                onPressed: _handleShowCreateChatRoomDialog,
                icon: SvgPicture.asset(AssetPath.add))
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await _handleGetChatRooms();
          },
          child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (_, index) =>
                  _ChatRoomListTile(widget.state.chatRooms[index]),
              separatorBuilder: (_, __) => const Divider(),
              itemCount: widget.state.chatRooms.length),
        ),
      );
}

class _ChatRoomListTile extends StatelessWidget {
  const _ChatRoomListTile(this.chatRoom, {super.key});

  final ChatRoomModel chatRoom;

  _handleGoToChatRoom(BuildContext context) => () {
        if (chatRoom.chatRoomId == null) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('존재하지 않는 채팅방입니다'),
            duration: Duration(seconds: 2),
          ));
          return;
        }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => ChatRoomScreen(chatRoom.chatRoomId!),
          ),
        );
      };

  @override
  Widget build(BuildContext context) => ListTile(
        onTap: _handleGoToChatRoom(context),
        // TODO : 호스트 프로필 사진
        leading: const CircleAvatar(),
        title: Text(
          chatRoom.chatRoomName ?? '',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.primary),
        ),
        subtitle: Row(
          children: chatRoom.hashtags
              .map((e) => Row(
                    children: [
                      Icon(Icons.tag,
                          size: 20,
                          color: Theme.of(context).colorScheme.secondary),
                      const SizedBox(width: 5),
                      Text(e,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary)),
                      const SizedBox(width: 5)
                    ],
                  ))
              .toList(),
        ),
        trailing: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.more_vert,
            color: Theme.of(context).colorScheme.contentFourth,
          ),
        ),
      );
}
