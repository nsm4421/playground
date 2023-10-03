import 'package:commerce_app/view/pages/home/component/view_module_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/utils/common.dart';
import '../../../../domain/model/menu_model.dart';
import '../../../../domain/usecase/display/display_usecase.dart';
import '../../../../service_locator.dart';
import '../bloc/view_module_bloc.dart';
import '../bloc/view_module_event.dart';

class GlobalNavbarView extends StatelessWidget {
  const GlobalNavbarView({
    super.key,
    required this.menus,
    required this.mallType,
  });

  final List<MenuModel> menus;
  final MallType mallType;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TabBarView(
        children: List.generate(
          menus.length,
          (index) => BlocProvider(
            create: (_) => locator<ViewModuleBloc>()
              ..add(ViewModuleInitialized(
                menus[index].tabId,
              )),
            child: ViewModuleList(),
          ),
        ),
      ),
    );
  }
}
