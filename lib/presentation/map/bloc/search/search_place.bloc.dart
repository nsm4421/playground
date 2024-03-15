import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hot_place/domain/usecase/map/search_place_by_category.usecase.dart';
import 'package:hot_place/domain/usecase/map/search_place_by_category_and_keyword.usecase.dart';
import 'package:hot_place/presentation/map/bloc/search/search_place.event.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import '../../../../core/constant/response.constant.dart';
import '../../../../domain/usecase/map/get_current_location.usecase.dart';
import 'search_place.state.dart';

@injectable
class SearchPlaceBloc extends Bloc<SearchPlaceEvent, SearchPlaceState> {
  SearchPlaceBloc({
    required GetCurrentLocationUseCase getCurrentLocationUseCase,
    required SearchPlaceByCategoryAndKeywordUseCase
        searchPlaceByCategoryAndKeywordUseCase,
    required SearchPlaceByCategoryUseCase searchPlaceByCategoryUseCase,
  })  : _getCurrentLocationUseCase = getCurrentLocationUseCase,
        _searchPlaceByCategoryAndKeywordUseCase =
            searchPlaceByCategoryAndKeywordUseCase,
        _searchPlaceByCategoryUseCase = searchPlaceByCategoryUseCase,
        super(const SearchPlaceState()) {
    on<InitSearch>(_onInit);
    on<SearchByCategory>(_searchByCategory);
    on<SearchByCategoryAndKeyword>(_searchByCategoryAndKeyword);
  }

  final Logger _logger = Logger();

  final GetCurrentLocationUseCase _getCurrentLocationUseCase;
  final SearchPlaceByCategoryAndKeywordUseCase
      _searchPlaceByCategoryAndKeywordUseCase;
  final SearchPlaceByCategoryUseCase _searchPlaceByCategoryUseCase;

  Future<void> _onInit(
    InitSearch event,
    Emitter<SearchPlaceState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final currentLocation = await _getCurrentLocation();
      emit(state.copyWith(
          currentLocation: currentLocation, status: Status.success));
      _logger.d(
          '현재 위치 : 위도 ${currentLocation.latitude} 경도 ${currentLocation.longitude}');
    } catch (err) {
      _logger.e(err);
      emit(state.copyWith(status: Status.error));
    }
  }

  Future<void> _searchByCategory(
    SearchByCategory event,
    Emitter<SearchPlaceState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final radius = event.radius ?? state.radius;
      final res = await _searchPlaceByCategoryUseCase(
          category: event.category,
          position: state.currentLocation,
          radius: radius);
      emit(state.copyWith(
          category: event.category,
          places: res.data,
          radius: radius,
          status: Status.success));
    } catch (err) {
      _logger.e(err);
      emit(state.copyWith(status: Status.error));
    }
  }

  Future<void> _searchByCategoryAndKeyword(
    SearchByCategoryAndKeyword event,
    Emitter<SearchPlaceState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final radius = event.radius ?? state.radius;
      final res = await _searchPlaceByCategoryAndKeywordUseCase(
          category: event.category,
          keyword: event.keyword,
          radius: radius,
          position: state.currentLocation);
      _logger.d(event.toString());
      emit(state.copyWith(
          category: event.category,
          keyword: event.keyword,
          places: res.data,
          radius: radius,
          status: Status.success));
    } catch (err) {
      _logger.e(err);
      emit(state.copyWith(status: Status.error));
    }
  }

  Future<Position> _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      throw Exception('not permitted');
    }
    return await _getCurrentLocationUseCase();
  }
}
