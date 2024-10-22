import 'dart:async';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:travel/core/util/util.dart';
import 'package:travel/domain/entity/registration/registration.dart';
import 'package:travel/presentation/bloc/registration/display/display_registration.bloc.dart';

import '../../../../../core/constant/constant.dart';
import '../../../../../core/di/dependency_injection.dart';
import '../../../../../domain/entity/meeting/meeting.dart';
import '../../../../bloc/auth/authentication.bloc.dart';
import '../../../../bloc/bloc_module.dart';
import '../../../../bloc/registration/edit/edit_registration.bloc.dart';
import '../../../../widgets/widgets.dart';

part 's_meeting_detail.dart';

part 's_comment.dart';

part 's_display_accompany.dart';

part 's_edit_accompany.dart';

part 'f_accompany.dart';

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
    final isAuthor =
        context.read<AuthenticationBloc>().state.currentUser!.uid ==
            widget._meeting.createdBy;
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) =>
                  getIt<BlocModule>().displayRegistration(widget._meeting)),
          BlocProvider(
              create: (_) =>
                  getIt<BlocModule>().editRegistration(widget._meeting))
        ],
        child: Scaffold(
            appBar: AppBar(
                leading: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      context.pop();
                    }),
                actions: [
                  // TODO : 더보기 버튼 기능개발
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.more_vert))
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
                    0 => MeetingDetailScreen(widget._meeting),
                    1 => const CommentScreen(),
                    (_) =>
                      BlocListener<EditRegistrationBloc, EditRegistrationState>(
                        listener: (context, state) {
                          if (state.status == Status.error) {
                            customUtil.showErrorSnackBar(
                                context: context, message: state.errorMessage);
                            Timer(const Duration(seconds: 1), () {
                              context.read<EditRegistrationBloc>().add(
                                  InitEditRegistrationEvent(
                                      status: Status.initial,
                                      errorMessage: ''));
                            });
                          }
                        },
                        child: BlocBuilder<DisplayRegistrationBloc,
                            CustomDisplayState<RegistrationEntity>>(
                          builder: (context, state) {
                            return LoadingOverLayScreen(
                                isLoading: state.status == Status.loading,
                                loadingWidget: const Center(
                                    child: CircularProgressIndicator()),
                                childWidget: isAuthor
                                    ? const EditAccompanyScreen()
                                    : DisplayAccompanyScreen(state.data));
                          },
                        ),
                      ),
                  };
                })));
  }
}
