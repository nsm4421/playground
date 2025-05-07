import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../common/utils/common.dart';
import '../../../../../common/utils/error/error_response.dart';
import '../../../../../domain/model/menu_model.dart';

part '../../../../../generated/menu_state.freezed.dart';

@freezed
class MenuState with _$MenuState {
  const factory MenuState({
    @Default(Status.initial) Status status,
    @Default(MallType.market) MallType mallType,
    @Default(<MenuModel>[]) List<MenuModel> menus,
    @Default(ErrorResponse()) ErrorResponse error,
  }) = _MenuState;
}
