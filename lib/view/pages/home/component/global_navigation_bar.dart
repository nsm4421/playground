import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:commerce_app/common/theme/custom/custom_font_weight.dart';
import '../../../../common/theme/custom/custom_theme.dart';
import '../../../../domain/model/menu_model.dart';
import '../../../../domain/usecase/display/display_usecase.dart';
import '../../../../service_locator.dart';
import '../bloc/view_module/view_module_bloc.dart';
import '../bloc/view_module/view_module_event.dart';
import 'view_module_list.dart';

class GlobalNavBar extends StatelessWidget {
  const GlobalNavBar({super.key, required this.menus});

  static const double _labelPadding = 8;
  final List<MenuModel> menus;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return TabBar(
      tabs: List.generate(
        menus.length,
        (index) => Tab(text: menus[index].title),
      ),
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: colorScheme.primary, width: 2),
      ),
      labelStyle: textTheme.titleSmall.semiBold,
      labelPadding: EdgeInsets.symmetric(horizontal: _labelPadding),
      unselectedLabelColor: colorScheme.contentPrimary,
      unselectedLabelStyle: textTheme.titleSmall,
    );
  }
}
