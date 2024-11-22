import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:travel/core/abstract/abstract.dart';
import 'package:travel/core/constant/constant.dart';

part 'display_state.dart';

part 'display_event.dart';

abstract class CustomDisplayBloc<T extends BaseEntity>
    extends Bloc<CustomDisplayEvent<T>, CustomDisplayState<T>> {
  CustomDisplayBloc() : super(CustomDisplayState<T>()) {
    on<InitDisplayEvent<T>>(_onInit);
    on<FetchEvent<T>>(onFetch);
  }

  DateTime get currentDt => DateTime.now().toUtc();

  Future<void> _onInit(
      InitDisplayEvent<T> event, Emitter<CustomDisplayState<T>> emit) async {
    emit(
      state.copyWith(
        status: event.status,
        data: event.data,
        errorMessage: event.errorMessage,
      ),
    );
  }

  Future<void> onFetch(
      FetchEvent<T> event, Emitter<CustomDisplayState<T>> emit);
}
