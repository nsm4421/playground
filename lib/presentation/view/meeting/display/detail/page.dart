import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:travel/domain/entity/auth/presence.dart';
import 'package:travel/domain/entity/meeting/meeting.dart';
import 'package:travel/presentation/widgets/widgets.dart';

part 'f_description.dart';

part 'f_header.dart';

part 'f_accompany.dart';

part 'w_fab.dart';

class MeetingDetailPage extends StatefulWidget {
  const MeetingDetailPage(this.entity, {super.key});

  final MeetingEntity entity;

  @override
  State<MeetingDetailPage> createState() => _MeetingDetailPageState();
}

class _MeetingDetailPageState extends State<MeetingDetailPage> {
  // TODO : 현재 몇 명 모였는지
  final accompanies = [
    PresenceEntity(
        uid: 'test1',
        username: 'test11',
        avatarUrl: 'https://picsum.photos/id/237/200/300'),
    PresenceEntity(
        uid: 'test2',
        username: 'test12',
        avatarUrl: 'https://picsum.photos/id/237/200/300'),
    PresenceEntity(
        uid: 'test3',
        username: 'test13',
        avatarUrl: 'https://picsum.photos/id/237/200/300'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.entity.title ?? ''),
        actions: [
          // TODO : 신고기능 개발하기
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.report_gmailerrorred))
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          // 썸네일
          if (widget.entity.thumbnail != null)
            Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        image: CachedNetworkImageProvider(
                            widget.entity.thumbnail!)))),

          // 상세 내용
          DescriptionFragment(widget.entity),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            child: Divider()
          ),

          // 동행자 목록
          AccompanyFragment(entity: widget.entity, accompanies: accompanies),

          const SizedBox(height: 50),
        ],
      )),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: const FabWidget(),
    );
  }
}
