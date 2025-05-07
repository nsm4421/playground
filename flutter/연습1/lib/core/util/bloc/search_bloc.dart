import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:travel/core/abstract/abstract.dart';
import 'package:travel/core/constant/constant.dart';
import 'package:travel/core/util/bloc/display_bloc.dart';

part 'search_state.dart';

part 'search_event.dart';

abstract class CustomSearchBloc<T extends BaseEntity, S>
    extends Bloc<CustomSearchEvent<T, S>, CustomSearchState<T, S>> {
  CustomSearchBloc() : super(CustomSearchState<T, S>()) {
    on<InitSearchEvent<T, S>>(_onInit);
    on<ClearSearchOptionEvent<T, S>>(_onClear);
    on<FetchEvent<T, S>>(onFetch);
    on<SearchOptionEditedEvent<T, S>>(onChangeOption);
  }

  DateTime get currentDt => DateTime.now().toUtc();

  Future<void> _onInit(InitSearchEvent<T, S> event,
      Emitter<CustomSearchState<T, S>> emit) async {
    emit(
      state.copyWith(
          status: event.status,
          data: event.data,
          errorMessage: event.errorMessage),
    );
  }

  Future<void> _onClear(ClearSearchOptionEvent<T, S> event,
      Emitter<CustomSearchState<T, S>> emit) async {
    emit(
      state.copyWithOption(null),
    );
  }

  Future<void> onFetch(
      FetchEvent<T, S> event, Emitter<CustomSearchState<T, S>> emit);

  Future<void> onChangeOption(SearchOptionEditedEvent<T, S> event,
      Emitter<CustomSearchState<T, S>> emit);
}
