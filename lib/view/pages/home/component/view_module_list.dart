import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/utils/common.dart';
import '../bloc/view_module_bloc.dart';
import '../bloc/view_module_state.dart';

class ViewModuleList extends StatelessWidget {
  const ViewModuleList({super.key});

  static const double _dividerThickness = 4;

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<ViewModuleBloc, ViewModuleState>(builder: (
        BuildContext _,
        ViewModuleState state,
      ) {
        switch (state.status) {
          case Status.initial:
          case Status.loading:
            return Center(
              child: CircularProgressIndicator(),
            );
          case Status.success:
            return Center(
              child: Column(
                children: [
                  ListView.separated(
                    shrinkWrap: true,
                    // TODO : view model UI 수정하기
                    itemBuilder: (BuildContext _, int index) =>
                        Text(state.viewModules[index].toString()),
                    separatorBuilder: (BuildContext _, int __) => Divider(
                      thickness: _dividerThickness,
                    ),
                    itemCount: state.viewModules.length,
                  ),
                ],
              ),
            );
          case Status.error:
            return Center(
              child: Text("error"),
            );
        }
      });
}
