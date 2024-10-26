import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../constant/constant.dart';
import '../response/error_response.dart';
import '../util/util.dart';

part 'display_state.dart';

part 'display_event.dart';

abstract class CustomDisplayBloc<T extends BaseEntity>
    extends Bloc<CustomDisplayEvent<T>, CustomDisplayState<T>> {
  CustomDisplayBloc() : super(CustomDisplayState<T>()) {
    on<InitDisplayEvent<T>>(onInit);
    on<FetchEvent<T>>(onFetch);
  }

  Future<void> onInit(
      InitDisplayEvent<T> event, Emitter<CustomDisplayState<T>> emit) async {
    emit(state.copyWith(
        status: event.status,
        data: event.data,
        errorMessage: event.errorMessage));
  }

  Future<void> onFetch(
      FetchEvent<T> event, Emitter<CustomDisplayState<T>> emit);
}
