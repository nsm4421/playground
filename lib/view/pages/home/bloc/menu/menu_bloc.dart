import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../common/utils/common.dart';
import '../../../../../common/utils/custom_logger.dart';
import '../../../../../common/utils/error/custom_exception.dart';
import '../../../../../domain/model/menu_model.dart';
import '../../../../../domain/model/result.dart';
import '../../../../../domain/usecase/display/display_usecase.dart';
import '../../../../../domain/usecase/display/menu/get_menus_usecase.dart';
import 'menu_event.dart';
import 'menu_state.dart';

@injectable
class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final DisplayUseCase _displayUseCase;

  MenuBloc(this._displayUseCase) : super(MenuState()) {
    on<MenuInitialized>(_onMenuInitialized);
  }

  Future<void> _onMenuInitialized(
    MenuInitialized event,
    Emitter<MenuState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final Result<List<MenuModel>> response = await _displayUseCase.execute(
        remoteUseCase: GetMenusUseCase(event.mallType),
      );
      response.when(
        success: (menus) {
          emit(state.copyWith(
            status: Status.success,
            menus: menus,
            mallType: event.mallType,
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
