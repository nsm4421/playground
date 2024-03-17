import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hot_place/core/di/dependency_injection.dart';
import 'package:hot_place/core/util/uuid.util.dart';
import 'package:hot_place/data/data_source/chat/chat.data_source.dart';
import 'package:hot_place/data/model/chat/chat.model.dart';
import 'package:hot_place/domain/repository/chat/chat.repository.dart';
import 'package:hot_place/presentation/chat/bloc/chat_room/chat_room.bloc.dart';
import 'package:hot_place/presentation/chat/bloc/chat_room/chat_room.event.dart';
import 'package:hot_place/presentation/main/bloc/auth/auth.bloc.dart';
import 'package:hot_place/presentation/main/bloc/auth/auth.event.dart';

import '../../../core/constant/route.constant.dart';

class ChatFragment extends StatelessWidget {
  const ChatFragment({super.key});

  @override
  Widget build(BuildContext context) => Column(
        children: [
          ElevatedButton(
              onPressed: () {
                context.read<AuthBloc>().add(SignOutEvent());
              },
              child: Text("Logout")),
          // ElevatedButton(
          //     onPressed: () {
          //       getIt<ChatDataSource>().createChat(
          //         ChatModel(
          //           id: UuidUtil.uuid(),
          //           opponentUid: 'dZ2BxUreu3M31RM8lqCJY5gXUkm2',
          //
          //         )
          //       );
          //     },
          //     child: Text("create")),
          ElevatedButton(
            onPressed: () {
              context.push(
                  "${Routes.chatRoom.path}/42e1929a-2f03-48ea-9b5b-018f8de6f45b");
            },
            child: Text("chat"),
          ),
        ],
      );
}
