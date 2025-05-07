import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel/core/constant/constant.dart';
import 'package:travel/core/util/bloc/search_bloc.dart';
import 'package:travel/core/util/logger/logger.dart';
import 'package:travel/domain/entity/feed/feed.dart';
import 'package:travel/domain/usecase/feed/usecase.dart';

class SearchFeedBloc extends CustomSearchBloc<FeedEntity, SearchFeedOption>
    with CustomLogger {
  final FeedUseCase _useCase;

  SearchFeedBloc(this._useCase);

  @override
  Future<void> onChangeOption(
      SearchOptionEditedEvent<FeedEntity, SearchFeedOption> event,
      Emitter<CustomSearchState<FeedEntity, SearchFeedOption>> emit) async {
    emit(state.copyWithOption(event.option));
  }

  @override
  Future<void> onFetch(FetchEvent<FeedEntity, SearchFeedOption> event,
      Emitter<CustomSearchState<FeedEntity, SearchFeedOption>> emit) async {
    try {
      logger.t(
          'search feed|option:${state.option?.searchField},${state.option?.searchText}');
      emit(state.copyWith(status: Status.loading));
      await _useCase.search
          .call(
              beforeAt: event.refresh ? currentDt : state.beforeAt,
              searchField: state.option?.searchField,
              searchText: state.option?.searchText,
              take: event.take)
          .then((res) => res.fold(
              (l) => emit(state.copyWith(
                  status: Status.error, errorMessage: l.message)),
              (r) => emit(state.copyWith(
                  status: Status.success,
                  errorMessage: '',
                  data: event.refresh ? r : [...state.data, ...r],
                  isEnd: r.length < event.take))));
    } catch (error) {
      logger.e(error);
      emit(state.copyWith(
          status: Status.error, errorMessage: 'fail to fetch feed'));
    }
  }
}
