part of '../export.core.dart';

abstract class DisplayBloc<T extends Entity>
    extends Bloc<DisplayEvent, DisplayState<T>> {
  DisplayBloc() : super(DisplayState<T>()) {
    on<InitDisplayEvent>(onInit);
    on<MountEvent>(onMount);
    on<FetchEvent>(onFetch);
  }

  Future<void> onInit(
      InitDisplayEvent event, Emitter<DisplayState<T>> emit) async {
    emit(state.copyWith(status: event.status, message: event.message));
  }

  Future<void> onMount(MountEvent event, Emitter<DisplayState<T>> emit);

  Future<void> onFetch(FetchEvent event, Emitter<DisplayState<T>> emit);
}
