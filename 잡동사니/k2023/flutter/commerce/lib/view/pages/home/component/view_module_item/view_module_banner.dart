import 'package:flutter/cupertino.dart';

import '../../../../../domain/model/view_module_model.dart';

class ViewModuleBanner extends StatelessWidget {
  const ViewModuleBanner(this._viewModuleModel, {super.key});

  static const _aspectRatio = 375 / 79;
  final ViewModuleModel _viewModuleModel;

  @override
  Widget build(BuildContext context) => (_viewModuleModel.imageUrl.isNotEmpty)
      ? AspectRatio(
          aspectRatio: _aspectRatio,
          child: Image.network(
            _viewModuleModel.imageUrl,
            fit: BoxFit.fitWidth,
          ),
        )
      // 이미지 url이 없는 경우 빈 박스
      : SizedBox.shrink();
}
