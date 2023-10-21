import 'package:flutter/material.dart';
import 'package:my_app/model/user/user.model.dart';
import 'package:my_app/presentation/components/user_image_carousel.widget.dart';

class UserBottomModal extends StatelessWidget {
  const UserBottomModal(this.user, {super.key});

  final UserModel user;

  static const double _padding = 10;

  _handlePop(BuildContext context) => () => Navigator.pop(context);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Column(
          children: [
            // 유저 이미지 Carousel - 두번 탭하면 화면 내리기
            GestureDetector(
              onDoubleTap: _handlePop(context),
              child: UserImageCarouselWidget(user),
            ),
            const Divider(),

            // 유저 세부정보
            Container(
              padding: const EdgeInsets.all(_padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 닉네임, 나이
                  Row(
                    children: [
                      Text(
                        "${user.nickname}",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: _padding),
                      Text("(${user.age})",
                          style: Theme.of(context).textTheme.bodyLarge),
                      const Expanded(child: SizedBox()),
                      IconButton(
                          onPressed: _handlePop(context),
                          icon: const Icon(Icons.cancel_outlined))
                    ],
                  ),
                  const Divider(),

                  // 키
                  Row(
                    children: [
                      const Chip(label: Text("키")),
                      const SizedBox(width: 15),
                      Text("${user.height} cm",
                          style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                  const Divider(),

                  // 사는 곳
                  Row(
                    children: [
                      const Chip(label: Text("사는 곳")),
                      const SizedBox(width: 15),
                      Text("${user.city}",
                          style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                  const Divider(),

                  // 이상형
                  Row(
                    children: [
                      const Chip(label: Text("이상형")),
                      const SizedBox(width: 15),
                      Text("${user.ideal}",
                          style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                  const Divider(),

                  // 직업
                  Row(
                    children: [
                      const Chip(label: Text("직업")),
                      const SizedBox(width: 15),
                      Text("${user.job}",
                          style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                  const Divider(),

                  // 자기소개
                  const Chip(label: Text("자기소개")),
                  Text("${user.introduce}"),
                  const SizedBox(height: 50)
                ],
              ),
            )
          ],
        ),
      );
}
