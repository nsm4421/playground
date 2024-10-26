import 'dart:async';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:travel/presentation/bloc/comment/display/display_comment.bloc.dart';
import 'package:travel/presentation/bloc/comment/edit/edit_comment.bloc.dart';

import '../../../../../core/bloc/display_bloc.dart';
import '../../../../../core/constant/constant.dart';
import '../../../../../core/di/dependency_injection.dart';
import '../../../../../core/util/util.dart';
import '../../../../../domain/entity/comment/comment.dart';
import '../../../../../domain/entity/meeting/meeting.dart';
import '../../../../../domain/entity/registration/registration.dart';
import '../../../../bloc/auth/authentication.bloc.dart';
import '../../../../bloc/bloc_module.dart';
import '../../../../bloc/registration/display/display_registration.bloc.dart';
import '../../../../bloc/registration/edit/edit_registration.bloc.dart';
import '../../../../widgets/widgets.dart';

part 'home/s_meeting_detail_home.dart';

part 'comment/s_comment.dart';

part 'comment/f_display_comment.dart';

part 'comment/w_edit_comment.dart';

part 'accompany/s_accompany.dart';

part 'accompany/f_edit_accompany.dart';


part 'accompany/w_proposer_registration.dart';

part 'accompany/w_manager_registration.dart';

part 'w_fab.dart';

class MeetingDetailPage extends StatefulWidget {
  const MeetingDetailPage(this._meeting, {super.key});

  final MeetingEntity _meeting;

  @override
  State<MeetingDetailPage> createState() => _MeetingDetailPageState();
}

class _MeetingDetailPageState extends State<MeetingDetailPage>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late PageController _pageController;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  context.pop();
                }),
            actions: [
              // TODO : 더보기 버튼 기능개발
              IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
            ],
            title: TabBar(
                controller: _tabController,
                onTap: (value) {
                  _currentIndex = value;
                  _pageController.animateToPage(_currentIndex,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease);
                },
                tabs: const [
                  Tab(icon: Icon(Icons.home_outlined)),
                  Tab(icon: Icon(Icons.comment_outlined)),
                  Tab(icon: Icon(Icons.group))
                ])),
        body: PageView.builder(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return switch (index) {
                /// 미팅 세부내용
                0 => MeetingDetailHomeScreen(widget._meeting),

                /// 댓글
                1 => MultiBlocProvider(providers: [
                    BlocProvider(
                        create: (_) => getIt<BlocModule>()
                            .displayMeetingComment(widget._meeting)
                          ..add(FetchEvent<CommentEntity>())),
                    BlocProvider(
                        create: (_) => getIt<BlocModule>()
                            .editMeetingComment(widget._meeting))
                  ], child: const CommentScreen()),

                /// 동반자 목록
                (_) => MultiBlocProvider(providers: [
                    BlocProvider(
                        create: (_) => getIt<BlocModule>()
                            .displayRegistration(widget._meeting)
                    ..add(FetchEvent<RegistrationEntity>())
                    ),
                    BlocProvider(
                        create: (_) => getIt<BlocModule>()
                            .editRegistration(widget._meeting)),
                  ], child: AccompanyScreen(widget._meeting)),
              };
            }));
  }
}
