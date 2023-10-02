import '../../../../common/utils/common.dart';

abstract class MenuEvent {
  const MenuEvent();
}

class MenuInitialized extends MenuEvent {
  final MallType mallType;

  MenuInitialized(this.mallType);
}
