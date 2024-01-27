import '../../../common/constants.dart';

enum NotificationType {
  tossPay("토스페이", "$basePath/notification/notification_toss.png"),
  luck("행운복권", "$basePath/notification/notification_luck.png"),
  people("행운복권", "$basePath/notification/notification_people.png"),
  stock("토스증권 컨텐츠", "$basePath/notification/notification_stock.png"),
  walk("만보기", "$basePath/notification/notification_walk.png"),
  moneyTip("만보기", "$basePath/notification/notification_idea.png"),
  ;

  const NotificationType(
    this.name,
    this.iconPath,
  );

  final String iconPath;
  final String name;
}
