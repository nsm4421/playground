import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../common/utils/common.dart';
import '../../../../common/utils/error/error_response.dart';
import '../../../../domain/model/view_module_model.dart';
import '../component/view_module_widget.dart';

part '../../../generated/view_module_state.freezed.dart';


@freezed
class ViewModuleState with _$ViewModuleState {
  const factory ViewModuleState({
    @Default(Status.initial) Status status,
    @Default(-1) int tabId,
    @Default(<ViewModuleWidget>[]) List<ViewModuleWidget> viewModuleWidgets,
    @Default(ErrorResponse()) ErrorResponse error,
  }) = _ViewModuleState;
}
