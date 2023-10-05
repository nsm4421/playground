import '../../../../../common/widget/product_card_widget.dart';
import '../../../../../domain/model/view_module_model.dart';
import 'package:flutter/material.dart';

class ScrollViewModule extends StatelessWidget {
  const ScrollViewModule(this._viewModuleModel, {super.key});

  final ViewModuleModel _viewModuleModel;

  @override
  Widget build(BuildContext context) {
    return LargeProductCardComponent(
      context: context,
      productInfoModel: _viewModuleModel.products.first,
    );
  }
}
