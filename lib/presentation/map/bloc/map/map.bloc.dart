import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hot_place/domain/usecase/map/get_current_location.usecase.dart';
import 'package:hot_place/presentation/map/bloc/map/map.event.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import 'map.state.dart';

@injectable
class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc({
    required GetCurrentLocationUseCase getCurrentLocationUseCase,
  })  : _getCurrentLocationUseCase = getCurrentLocationUseCase,
        super(const MapState()) {
    on<InitMap>(_onInit);
  }

  final Logger _logger = Logger();

  final GetCurrentLocationUseCase _getCurrentLocationUseCase;

  Future<void> _onInit(
    InitMap event,
    Emitter<MapState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      // 위치 권한
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        emit(state.copyWith(isError: false));
        return;
      }

      // 현재 위치 설정
      (await _getCurrentLocationUseCase()).when(success: (data) {
        emit(state.copyWith(currentLocation: data));
      }, failure: (code, description) {
        throw Exception("error-code:$code: ($description)");
      });
    } catch (err) {
      _logger.e(err);
      emit(state.copyWith(isError: true));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }
}
