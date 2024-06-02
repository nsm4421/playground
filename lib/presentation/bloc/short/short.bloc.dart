import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/domain/usecase/module/short/short.usecase.dart';

import '../../../data/entity/short/short.entity.dart';

part "short.state.dart";

part "short.event.dart";

@injectable
class ShortBloc extends Bloc<ShortEvent, ShortState> {
  final ShortUseCase _useCase;

  ShortBloc({required ShortUseCase useCase})
      : _useCase = useCase,
        super(InitialShortState()) {
    on<FetchShortEvent>(_onFetch);
  }

  DateTime? _lastFetchedAt;

  Stream<List<ShortEntity>> get shortStream => _useCase.shortStream.call();

  Future<void> _onFetch(FetchShortEvent event, Emitter<ShortState> emit) async {
    try {
      emit(ShortLoadingState());
      _lastFetchedAt = DateTime.now();
      await _useCase
          .getShorts(
              afterAt: _lastFetchedAt?.toIso8601String(),
              take: event.take ?? 20)
          .then((res) => res.fold(
              (l) =>
                  emit(ShortFailureState(l.message ?? 'getting short fails')),
              (r) => emit(ShortSuccessState(r))));
    } catch (error) {
      log(error.toString());
      emit(ShortFailureState('getting short fails'));
    }
  }
}
