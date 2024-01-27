import 'package:fast_app_base/common/common.dart';
import 'package:flutter/material.dart';

import '../../../../common/widget/w_arrow.dart';

class BenefitButtonWidget extends StatelessWidget {
  final int point;

  const BenefitButtonWidget({super.key, required this.point});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        "내 포인트".text.color(Colors.grey).make(),
        const Expanded(child: SizedBox()),
        "$point 원".text.white.bold.make(),
        const Arrow(color: Colors.white,),
      ],
    );
  }
}
