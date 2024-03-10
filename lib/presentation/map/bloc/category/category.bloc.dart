import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hot_place/domain/usecase/map/search_by_category.usecase.dart';
import 'package:hot_place/presentation/map/bloc/category/category.event.dart';
import 'package:hot_place/presentation/map/bloc/category/category.state.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import '../../../../core/constant/status.costant.dart';
import '../../../../domain/usecase/map/get_current_location.usecase.dart';

@injectable
class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc({
    required GetCurrentLocationUseCase getCurrentLocationUseCase,
    required SearchPlacesByCategoryUseCase searchPlacesByCategoryUseCase,
  })  : _getCurrentLocationUseCase = getCurrentLocationUseCase,
        _searchPlacesByCategoryUseCase = searchPlacesByCategoryUseCase,
        super(const CategoryState()) {
    on<InitCategory>(_onInit);
    on<CategoryChanged>(_onCategoryChanged);
  }

  final Logger _logger = Logger();

  final GetCurrentLocationUseCase _getCurrentLocationUseCase;
  final SearchPlacesByCategoryUseCase _searchPlacesByCategoryUseCase;

  Future<void> _onInit(
    InitCategory event,
    Emitter<CategoryState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));
    try {
      // 위치 권한
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        emit(state.copyWith(status: Status.error));
        return;
      }
      // 현재 위치 설정
      final currentLocation = await _getCurrentLocationUseCase();
      emit(state.copyWith(
          currentLocation: currentLocation, status: Status.success));
      _logger.d(
          '현재 위치 : 위도 ${currentLocation.latitude} 경도 ${currentLocation.longitude}');
    } catch (err) {
      _logger.e(err);
      emit(state.copyWith(status: Status.error));
    }
  }

  Future<void> _onCategoryChanged(
    CategoryChanged event,
    Emitter<CategoryState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final res = await _searchPlacesByCategoryUseCase(
          category: event.category, position: state.currentLocation);
      emit(state.copyWith(category: event.category, places: res.data, status: Status.success));
    } catch (err) {
      _logger.e(err);
      emit(state.copyWith(status: Status.error));
    }
  }
}
