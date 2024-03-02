import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hot_place/domain/usecase/map/get_current_location.usecase.dart';
import 'package:hot_place/presentation/map/bloc/map.event.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import 'map.state.dart';

@injectable
class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc({required GetCurrentLocationUseCase getCurrentLocationUseCase})
      : _getCurrentLocationUseCase = getCurrentLocationUseCase,
        super(const MapState()) {
    on<InitMap>(_onInit);
  }

  final Logger _logger = Logger();

  final GetCurrentLocationUseCase _getCurrentLocationUseCase;

  Future<void> _onInit(
    InitMap event,
    Emitter<MapState> emit,
  ) async {
    try {
      // 위치 권한
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        emit(state.copyWith(isPermitted: false));
        return;
      }

      // 현재 위치
      final location = await _getCurrentLocationUseCase();
      _logger.d('현재 위치 : 위도 ${location.latitude} 경도 ${location.longitude}');
      emit(state.copyWith(
        isPermitted: true,
        lat: location.latitude,
        lng: location.longitude,
      ));
    } catch (err) {
      _logger.e(err);
      emit(state.copyWith(isError: false));
    }
  }
}
