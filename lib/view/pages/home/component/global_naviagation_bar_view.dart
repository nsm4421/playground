import 'package:flutter/material.dart';

import '../../../../common/utils/common.dart';
import '../../../../domain/model/menu_model.dart';

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
          (index) => Column(
            children: [
              Text(menus[index].title??'title'),
            ],
          ),
        ),
      ),
    );
  }
}
