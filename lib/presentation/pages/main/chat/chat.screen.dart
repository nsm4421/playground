import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/data/entity/user/account.entity.dart';

import '../../../../core/constant/routes.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CHAT"),
        actions: [
          IconButton(
              onPressed: () {
                context.push(Routes.privateChatRoom.path,
                    extra: AccountEntity(
                        id: '5f866349-0684-499a-be41-38938b6b3175',
                        nickname: 'test2',
                        profileUrl:
                            'https://lwshjbjdarfenpzuuzdv.supabase.co/storage/v1/object/public/accounts/5f866349-0684-499a-be41-38938b6b3175/profile_image.jpg',
                        description: 'test2 user'));
              },
              icon: const Icon(Icons.add))
        ],
      ),
    );
  }
}
