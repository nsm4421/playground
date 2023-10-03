import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../component/view_module_widget.dart';
import 'view_module_event.dart';
import 'view_module_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/utils/common.dart';
import '../../../../../common/utils/custom_logger.dart';
import '../../../../../common/utils/error/custom_exception.dart';
import '../../../../../domain/model/result.dart';
import '../../../../../domain/model/view_module_model.dart';
import '../../../../../domain/usecase/display/display_usecase.dart';
import '../../../../../domain/usecase/display/view_module/get_view_modules_usecase.dart';

class ViewModuleBloc extends Bloc<ViewModuleEvent, ViewModuleState> {
  final DisplayUseCase _displayUseCase;

  static const int _durationMilliSec = 500;

  // bloc event 등록
  ViewModuleBloc(this._displayUseCase) : super(ViewModuleState()) {
    on<ViewModuleInitialized>(_onViewModuleInitialized);
    on<ViewModuleFetched>(
      _onViewModuleFetched,
      // 스크롤이 화면 맨 아래 가서 view module을 더 가져올 때, 메써드가 여러번 호출됨
      // throttling을 사용해 event 발생하면, 0.5초동안 다른 event가 들어오지 못하도록 함
      // → 한번만 이벤트 발생
      transformer: (events, mapper) => droppable<ViewModuleFetched>().call(
        events.throttle(Duration(milliseconds: _durationMilliSec)),
        mapper,
      ),
    );
  }

  /// 처음 렌더링 될 때
  Future<void> _onViewModuleInitialized(
    ViewModuleInitialized event,
    Emitter<ViewModuleState> emit,
  ) async {
    // 로딩중으로 상태 변경 후, 0.5초 기다리기
    emit(state.copyWith(status: Status.loading));
    await Future.delayed(Duration(milliseconds: _durationMilliSec));
    try {
      // view module 리스트 가져오기
      final Result<List<ViewModuleModel>> response =
          await _displayUseCase.execute<Result<List<ViewModuleModel>>>(
        remoteUseCase: GetViewModulesUseCase(tabId: event.tabId, page: 1),
      );
      response.when(
        // 성공인 경우, view module widgets 리스트 필드 상태 변경
        success: (viewModules) {
          emit(state.copyWith(
            status: Status.success,
            viewModuleWidgets: viewModules
                .map((viewModuleModel) => ViewModuleWidget(viewModuleModel))
                .toList(),
            tabId: event.tabId,
          ));
        },
        // 실패인 경우, error 필드 상태 변경
        failure: (e) {
          emit(state.copyWith(status: Status.error, error: e));
        },
      );
    } catch (e) {
      // 에러인 경우, 로그를 남기고, error 필드 상태 변경
      CustomLogger.logger.e(e);
      emit(state.copyWith(
        status: Status.error,
        error: CustomException.setError(e),
      ));
    }
  }

  /// view module 가져오기 요청
  Future<void> _onViewModuleFetched(
    ViewModuleFetched event,
    Emitter<ViewModuleState> emit,
  ) async {
    // 가장 마지막 페이지인 경우, 페이지 필드 상태 변경 후 return
    if (state.isLastPage) return;

    // 로딩중으로 상태 변경 후, 0.5초 기다리기
    emit(state.copyWith(status: Status.loading));
    await Future.delayed(Duration(milliseconds: _durationMilliSec));

    final int nextPage = state.currentPage + 1;
    final int tabId = state.tabId;
    try {
      // 다음 페이지 정보 가져오기
      final Result<List<ViewModuleModel>> response =
          await _displayUseCase.execute<Result<List<ViewModuleModel>>>(
        remoteUseCase: GetViewModulesUseCase(tabId: tabId, page: nextPage),
      );
      response.when(
        success: (data) {
          // 가져온 페이지에 정보가 없는 경우, 페이지, 가장 마자막 페이지 상태 변경 후, return
          if (data.isEmpty) {
            emit(state.copyWith(
              status: Status.success,
              tabId: tabId,
              isLastPage: true,
              currentPage: nextPage,
            ));

            return;
          }
          // 성공 시, 상태 변경
          emit(state.copyWith(
            status: Status.success,
            tabId: tabId,
            viewModuleWidgets: [
              ...state.viewModuleWidgets, // 기존 데이터
              ...data.map(
                (viewModuleModel) => ViewModuleWidget((viewModuleModel)),
              ), // 추가 데이터
            ],
            currentPage: nextPage,
          ));
        },
        // 실패인 경우, error 필드 상태 변경
        failure: (e) {
          emit(state.copyWith(status: Status.error, error: e));
        },
      );
    } catch (e) {
      // 에러인 경우, 로그를 남기고, error 필드 상태 변경
      CustomLogger.logger.e(e);
      emit(state.copyWith(
        status: Status.error,
        error: CustomException.setError(e),
      ));
    }
  }
}
