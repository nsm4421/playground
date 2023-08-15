import 'package:flutter/material.dart';
import 'package:flutter_prj/screen/custom_design/colors.dart';
import 'package:flutter_prj/screen/widgets/profile_image_widget.dart';

import '../custom_design/theme.dart';

class Chats extends StatefulWidget {
  const Chats();

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (_, idx) => _chatItem(),
        separatorBuilder: (_, __) => Divider(),
        // TODO : item 개수
        itemCount: 3);
  }

  _chatItem() => ListTile(
        /// profile image
        leading: const ProfileImage(
          // TODO : 프로필 이미지 가져오는 경로
          imageUrl: "https://picsum.photos/seed/picsum/200/300",
          isInternetConnected: true,
        ),

        /// 유저명
        title: Text(
          "유저명을 넣을 곳",
          style: Theme.of(context).textTheme.bodyMedium.copyWith(
              fontWeight: FontWeight.bold,
              color: isLightTheme(context) ? Colors.black : Colors.white),
        ),

        /// message
        subtitle: Text(
          "메세지를 넣을 곳",
          overflow: TextOverflow.ellipsis,
          softWrap: true,
          style: Theme.of(context).textTheme.bodySmall.copyWith(
              color: isLightTheme(context) ? Colors.black54 : Colors.white70),
        ),

        trailing: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              /// 메세지 보낸 시간
              Text(
                "메세지 보낸 시간을 넣을 곳",
                style: Theme.of(context).textTheme.labelSmall.copyWith(
                    color: isLightTheme(context)
                        ? Colors.black54
                        : Colors.white70),
              ),

              /// 읽지 않은 메세지 수
              ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: Container(
                  height: 15.0,
                  width: 15.0,
                  color: kPrimary,
                  alignment: Alignment.center,
                  child: Text(
                    "3+",
                    style: Theme.of(context).textTheme.labelSmall.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.white70),
                  ),
                ),
              )
            ],
          ),
        ),
      );
}
