import 'package:commerce_app/view/pages/home/component/view_module_item/view_module_scroll.dart';
import 'package:flutter/material.dart';

import '../../../../common/utils/common.dart';
import '../../../../domain/model/view_module_model.dart';
import 'view_module_item/view_module_banner.dart';
import 'view_module_item/view_module_carousel.dart';

class ViewModuleWidget extends StatelessWidget {
  const ViewModuleWidget(
    this.viewModuleModel, {
    super.key,
  });

  final ViewModuleModel viewModuleModel;

  @override
  Widget build(BuildContext context) {
    // type casting (string → enum)
    ViewModuleType? type;
    for (final t in ViewModuleType.values) {
      if (t.name.toUpperCase() == viewModuleModel.type.toUpperCase()) {
        type = t;
        break;
      }
    }

    // TODO : UI 변경하기
    switch (type) {
      case ViewModuleType.viewModuleA:
        return Container(
          color: Colors.red,
          height: 200,
          child: Center(child: Text('ViewModuleA')),
        );
      case ViewModuleType.viewModuleB:
        return Container(
          color: Colors.blueGrey,
          height: 200,
          child: Center(child: Text('ViewModuleB')),
        );
      case ViewModuleType.viewModuleC:
        return Container(
          color: Colors.yellow,
          height: 200,
          child: Center(child: Text('ViewModuleC')),
        );
      case ViewModuleType.viewModuleD:
        return Container(
          color: Colors.green,
          height: 200,
          child: Center(child: Text('ViewModuleD')),
        );
      case ViewModuleType.viewModuleE:
        return Container(
          color: Colors.blue,
          height: 200,
          child: Center(child: Text('ViewModuleE')),
        );
      case ViewModuleType.carousel_view_module:
        return ViewModuleCarousel(viewModuleModel);
      case ViewModuleType.banner_view_module:
        return ViewModuleBanner(viewModuleModel);
      case ViewModuleType.scroll_view_module:
        return ScrollViewModule(viewModuleModel);
      default:
        return SizedBox(
          height: 200,
          child: Center(
            child: Text('ViewModuleNone${viewModuleModel.type.toString()}'),
          ),
        );
    }
  }
}
