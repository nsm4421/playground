import 'package:fast_app_base/screen/main/tab/home/vo/mock_bank.dart';
import 'package:fast_app_base/screen/main/tab/home/vo/vo_account.dart';

final bankAccount1 =
    BankAccount(bankToss, 'test1', 'karma', 100000000, accountTypeName: 'toss');
final bankAccount2 =
    BankAccount(bankKakao, 'test2', 'karma', 100000000, accountTypeName: 'kakao');
final bankAccount3 =
    BankAccount(bankShinhan, 'test3', 'karma', 100000000, accountTypeName: 'shinhan');

final bankAccounts = [
  bankAccount1,
  bankAccount2,
  bankAccount3
];
