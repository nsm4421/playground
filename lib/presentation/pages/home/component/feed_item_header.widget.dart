import 'package:flutter/material.dart';

class FeedItemHeader extends StatelessWidget {
  const FeedItemHeader(this.uid, {super.key});

  final String uid;

  // TODO : 더보기 버튼 이벤트 등록
  void _handleClickMoreButton() {}

  @override
  Widget build(BuildContext context) => Row(
        children: [
          const SizedBox(width: 15),
          // TODO : 실제 유저의 프로필 사진 보여주기
          const CircleAvatar(),
          const SizedBox(width: 5),
          // TODO : 실제 유저의 닉네임 보여주기
          Text(uid,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const Spacer(),
          IconButton(
              onPressed: _handleClickMoreButton,
              icon: const Icon(Icons.more_vert, color: Colors.grey)),
          const SizedBox(width: 15)
        ],
      );
}
