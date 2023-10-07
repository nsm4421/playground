import '../../../../../common/widget/image_list_widget.dart';
import '../../../../../common/widget/view_module_subtitle_widget.dart';
import '../../../../../common/widget/view_module_title_widget.dart';
import '../../../../../domain/model/view_module_model.dart';
import 'package:flutter/material.dart';

class ViewModuleScroll extends StatelessWidget {
  const ViewModuleScroll(this._viewModuleModel, {super.key});

  final ViewModuleModel _viewModuleModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              ViewModuleTitleWidget(
                title: _viewModuleModel.title,
              ),
              if (_viewModuleModel.subtitle.isNotEmpty)
                ViewModuleSubtitleWidget(subtitle: _viewModuleModel.subtitle),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10, bottom: 50),
          child: ImageListWidget(
            products: _viewModuleModel.products,
          ),
        ),
      ],
    );
  }
}
