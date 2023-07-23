import 'package:fast_app_base/common/common.dart';
import 'package:flutter/material.dart';

import 'vo/vo_benefit.dart';

class BenefitItem extends StatelessWidget {
  final Benefit benefit;
  const BenefitItem({super.key, required this.benefit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Image.asset(benefit.imagePath, width: 50, height: 50,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              benefit.title.text.bold.white.make(),
              Height(20),
              benefit.subTitle.text.color(Colors.grey).make()
            ],
          )
        ],
      ),
    );
  }
}
