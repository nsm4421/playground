import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/theme/constant/icon_paths.dart';

enum BottomNavState { home, category, search, user }

class BottomNavCubit extends Cubit<BottomNavState> {
  BottomNavCubit() : super(BottomNavState.home);

  void handleIndex(int index) => emit(BottomNavState.values[index]);
}

extension BottomNavStateX on BottomNavState {
  SvgPicture get icon {
    switch (this) {
      case BottomNavState.home:
        return SvgPicture.asset(IconPaths.navHome);
      case BottomNavState.category:
        return SvgPicture.asset(IconPaths.navCategory);
      case BottomNavState.search:
        return SvgPicture.asset(IconPaths.navSearch);
      case BottomNavState.user:
        return SvgPicture.asset(IconPaths.navUser);
    }
  }

  SvgPicture get activeIcon {
    switch (this) {
      case BottomNavState.home:
        return SvgPicture.asset(IconPaths.navHomeOn);
      case BottomNavState.category:
        return SvgPicture.asset(IconPaths.navCategoryOn);
      case BottomNavState.search:
        return SvgPicture.asset(IconPaths.navSearchOn);
      case BottomNavState.user:
        return SvgPicture.asset(IconPaths.navUserOn);
    }
  }

  String get label {
    switch (this) {
      case BottomNavState.home:
        return 'home';
      case BottomNavState.category:
        return 'category';
      case BottomNavState.search:
        return 'search';
      case BottomNavState.user:
        return 'user';
    }
  }
}
