import 'package:flutter/material.dart';
import 'package:hot_place/data/entity/chat/private_chat/room/private_chat.entity.dart';
import 'package:hot_place/presentation/chat/widget/private_chat/private_chat_item.widget.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../domain/usecase/chat/room/private_chat.usecase.dart';

class PrivateChatListFragment extends StatefulWidget {
  const PrivateChatListFragment({super.key});

  @override
  State<PrivateChatListFragment> createState() =>
      _PrivateChatListFragmentState();
}

class _PrivateChatListFragmentState extends State<PrivateChatListFragment> {
  late ScrollController _scrollController;
  late Stream<List<PrivateChatEntity>> _stream;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _stream = getIt<PrivateChatUseCase>().chatStream.call();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<PrivateChatEntity>>(
        stream: _stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data ?? [];
            return ListView.builder(
                controller: _scrollController,
                itemCount: data.length,
                itemBuilder: (_, index) {
                  final chat = data[index];
                  return PrivateChatItemWidget(chat);
                });
          } else if (snapshot.hasError) {
            return const Text("ERROR");
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
