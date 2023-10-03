import 'package:flutter/cupertino.dart';

import '../component/view_module_widget.dart';
import 'view_module_event.dart';
import 'view_module_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/utils/common.dart';
import '../../../../common/utils/custom_logger.dart';
import '../../../../common/utils/error/custom_exception.dart';
import '../../../../domain/model/result.dart';
import '../../../../domain/model/view_module_model.dart';
import '../../../../domain/usecase/display/display_usecase.dart';
import '../../../../domain/usecase/display/view_module/get_view_modules_usecase.dart';

class ViewModuleBloc extends Bloc<ViewModuleEvent, ViewModuleState> {
  final DisplayUseCase _displayUseCase;

  ViewModuleBloc(this._displayUseCase) : super(ViewModuleState()) {
    on<ViewModuleInitialized>(_onViewModuleInitialized);
  }

  Future<Result<List<ViewModuleModel>>> _getViewModulesByTabId(
    int tabId,
  ) async =>
      await _displayUseCase.execute(
        remoteUseCase: GetViewModulesUseCase(tabId),
      );

  Future<void> _onViewModuleInitialized(
    ViewModuleInitialized event,
    Emitter<ViewModuleState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final Result<List<ViewModuleModel>> response =
          await _displayUseCase.execute(
        remoteUseCase: GetViewModulesUseCase(event.tabId),
      );
      response.when(
        success: (viewModules) {
          emit(state.copyWith(
            status: Status.success,
            viewModuleWidgets: (viewModules as List<ViewModuleModel>)
                .map((viewModuleModel) => ViewModuleWidget(viewModuleModel))
                .toList(),
            tabId: event.tabId,
          ));
        },
        failure: (e) {
          emit(state.copyWith(status: Status.error, error: e));
        },
      );
    } catch (e) {
      CustomLogger.logger.e(e);
      emit(state.copyWith(
        status: Status.error,
        error: CustomException.setError(e),
      ));
    }
  }
}
