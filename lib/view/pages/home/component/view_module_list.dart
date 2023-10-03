import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/utils/common.dart';
import '../bloc/view_module/view_module_bloc.dart';
import '../bloc/view_module/view_module_event.dart';
import '../bloc/view_module/view_module_state.dart';

class ViewModuleList extends StatefulWidget {
  const ViewModuleList({super.key});

  @override
  State<ViewModuleList> createState() => _ViewModuleListState();
}

class _ViewModuleListState extends State<ViewModuleList> {
  late ScrollController _scrollController;
  static const double _scrollThreshold = 0.9;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  // 전체 높이에 90%(threshold)에 도달 여부로, fetch 여부 가져오기
  void _onScroll() {
    if (!_scrollController.hasClients) {
      _scrollController = ScrollController();
    }
    final maxScrollSize = _scrollController.position.maxScrollExtent;
    final currentScrollSize = _scrollController.offset;

    final needToScroll = currentScrollSize >= maxScrollSize * _scrollThreshold;
    if (needToScroll) {
      context.read<ViewModuleBloc>().add(ViewModuleFetched());
    }
  }

  Widget _loadingWidget() => Center(
        child: SizedBox(
          width: 30,
          height: 30,
          child: CircularProgressIndicator(),
        ),
      );

  @override
  void dispose() {
    super.dispose();
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<ViewModuleBloc, ViewModuleState>(builder: (
        BuildContext _,
        ViewModuleState state,
      ) {
        // 로딩중
        if (state.status == Status.initial || state.viewModuleWidgets.isEmpty)
          return _loadingWidget();

        // 에러
        if (state.error == Status.error) return Text("ERROR");

        // 성공
        return ListView(
          controller: _scrollController,
          shrinkWrap: true,
          children: [
            ...state.viewModuleWidgets,
            if (state.status == Status.loading) _loadingWidget(),
          ],
        );
      });
}
