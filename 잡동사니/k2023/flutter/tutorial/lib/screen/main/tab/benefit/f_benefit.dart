import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/screen/main/tab/benefit/vo/vo_mock_benefit.dart';
import 'package:fast_app_base/screen/main/tab/benefit/w_benefit_button.dart';
import 'package:fast_app_base/screen/main/tab/benefit/w_benefit_item.dart';
import 'package:flutter/material.dart';


class BenefitFragment extends StatelessWidget {
  const BenefitFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Height(30),
            BenefitButtonWidget(point: 30,),
            Height(30),
            "혜택 더 받기".text.white.make(),
            ... benefitList.map((e)=>BenefitItem(benefit:e)).toList()
          ],
        ).pSymmetric(h:10),

      ),
    );
  }
}
