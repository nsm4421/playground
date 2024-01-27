import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/screen/notification/vo/notification_type.dart';
import 'package:fast_app_base/screen/notification/vo/vo_notification.dart';

final notifications = <TossNotification>[
  TossNotification(
      NotificationType.tossPay, "토스페이 메세지", DateTime.now().subtract(1.minutes)),
  TossNotification(
      NotificationType.luck, "행운 메세지", DateTime.now().subtract(2.minutes)),
  TossNotification(
      NotificationType.moneyTip, "머니팁 메세지", DateTime.now().subtract(3.minutes)),
  TossNotification(
      NotificationType.people, "사람 메세지", DateTime.now().subtract(4.minutes)),
  TossNotification(
      NotificationType.stock, "주식 메세지", DateTime.now().subtract(5.minutes)),
  TossNotification(
      NotificationType.walk, "걷기 메세지", DateTime.now().subtract(6.minutes)),
];
