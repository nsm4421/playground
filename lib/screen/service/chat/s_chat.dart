import 'package:chat_app/screen/service/chat/f_add_chat_room.dart';
import 'package:chat_app/screen/widget/w_box.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  _handleBottomModalSheet() => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) => const AddChatRoomFragment(),
      );

  AppBar _appBar() => AppBar(
        centerTitle: true,
        title: Text(
          "Chats",
          style: GoogleFonts.lobster(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _handleBottomModalSheet,
            icon: const Icon(
              Icons.add_box_outlined,
              size: 30,
            ),
          ),
        ],
      );

  _chatList() => ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        // single child scroll view 내부에서 list view를 사용하는 경우 해당 옵션을 주어야 스크롤 가능
        itemCount: 10,
        shrinkWrap: true,
        itemBuilder: (context, index) => ListTile(
          leading: CircleAvatar(
            child: Container(),
          ),
          tileColor: Colors.grey[100],
          title: const Text(
            "USERNAME",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          subtitle: const Text(
            "Last message",
            style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 15,
            ),
          ),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                "Last message",
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 10,
                ),
              ),
              const Height(5),
              Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.red,
                  ),
                  child: const Center(
                    child: Text(
                      "20",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  )),
            ],
          ),
          onTap: () {},
        ),
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _appBar(),
        body: SingleChildScrollView(
          child: _chatList(),
        ),
      ),
    );
  }
}
