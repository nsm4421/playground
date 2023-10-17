import 'package:flutter/material.dart';
import 'package:my_app/model/user/user.model.dart';
import 'package:my_app/presentation/components/user_image.widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // TODO - 실제 유저 정보 가져오기
  static const testUser = UserModel(
      nickname: "Karma",
      age: 30,
      height: 180,
      imageUrls: [
        "https://image-cdn.hypb.st/https%3A%2F%2Fkr.hypebeast.com%2Ffiles%2F2023%2F06%2Fdemon-slayer-season-4-confirmed-with-an-official-teaser-for-the-hashira-training-arc-05.jpg?cbr=1&q=90",
        "https://i.namu.wiki/i/Ck4owcmWrDjQuEi6V3dpgAw0arnw8_MQaAKHu5ApUOOZlcaHGxHkUukxn5JSo0GoqB-8e9dAMwQVveRwCAzJhg.webp"
      ],
      introduce: "안녕하세요~! \n 노량진 사는 ~~입니다");

  @override
  Widget build(BuildContext context) => const SingleChildScrollView(
        child: Column(
          children: [UserImageWidget(testUser)],
        ),
      );
}
