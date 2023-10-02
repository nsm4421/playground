import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/theme/constant/icon_paths.dart';
import '../../../common/utils/common.dart';

class BottomNavCubit extends Cubit<BottomNav> {
  BottomNavCubit() : super(BottomNav.home);

  void handleIndex(int index) => emit(BottomNav.values[index]);
}

extension BottomNavStateX on BottomNav {
  SvgPicture get icon {
    switch (this) {
      case BottomNav.home:
        return SvgPicture.asset(IconPaths.navHome);
      case BottomNav.category:
        return SvgPicture.asset(IconPaths.navCategory);
      case BottomNav.search:
        return SvgPicture.asset(IconPaths.navSearch);
      case BottomNav.user:
        return SvgPicture.asset(IconPaths.navUser);
    }
  }

  SvgPicture get activeIcon {
    switch (this) {
      case BottomNav.home:
        return SvgPicture.asset(IconPaths.navHomeOn);
      case BottomNav.category:
        return SvgPicture.asset(IconPaths.navCategoryOn);
      case BottomNav.search:
        return SvgPicture.asset(IconPaths.navSearchOn);
      case BottomNav.user:
        return SvgPicture.asset(IconPaths.navUserOn);
    }
  }

  String get label {
    switch (this) {
      case BottomNav.home:
        return 'home';
      case BottomNav.category:
        return 'category';
      case BottomNav.search:
        return 'search';
      case BottomNav.user:
        return 'user';
    }
  }
}
