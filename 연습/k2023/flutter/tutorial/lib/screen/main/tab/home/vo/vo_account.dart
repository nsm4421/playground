import 'package:fast_app_base/screen/main/tab/home/vo/vo_bank.dart';

class BankAccount {
  final Bank bank; // 은행
  final String accountNumber; // 계좌번호
  final String accountHolderName; // 예금주
  int balance; // 잔액
  final String? accountTypeName;

  BankAccount(
    this.bank,
    this.accountNumber,
    this.accountHolderName,
    this.balance, {
    this.accountTypeName,
  });
}
