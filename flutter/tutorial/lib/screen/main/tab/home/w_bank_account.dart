import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/common/widget/w_rounded_container.dart';
import 'package:fast_app_base/screen/main/tab/home/vo/vo_account.dart';
import 'package:flutter/material.dart';

class BankAccountWidget extends StatelessWidget {

  final BankAccount bankAccount;
  const BankAccountWidget({super.key, required this.bankAccount});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(bankAccount.bank.logoImagePath, width: 40),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              (bankAccount.accountTypeName ?? "${bankAccount.bank.name} 통장").text.white.size(12).make(),
              ("${bankAccount.balance}원").text.white.size(18).make(),
            ],
          ).pSymmetric(h:20,v:10),
        ),
        RoundedContainer(child: "송금".text.white.bold.make(), color: context.appColors.buttonBackground,)
      ],
    );
  }
}
