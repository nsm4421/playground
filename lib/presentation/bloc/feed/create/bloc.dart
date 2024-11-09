import 'dart:ffi';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:travel/core/abstract/abstract.dart';
import 'package:travel/core/constant/constant.dart';
import 'package:travel/core/util/logger/logger.dart';
import 'package:travel/domain/usecase/feed/usecase.dart';
import 'package:uuid/uuid.dart';

part 'state.dart';

part 'event.dart';

class CreateFeedBloc extends Bloc<CreateFeedEvent, CreateFeedState>
    with CustomLogger {
  final FeedUseCase _useCase;

  CreateFeedBloc(this._useCase)
      : super(CreateFeedState(id: const Uuid().v4())) {
    on<InitEvent>(_onInit);
    on<AskPermissionEvent>(_onAsk);
    on<OnMountEvent>(_onMount);
    on<OnTapImageEvent>(_onTap);
    on<SelectImageEvent>(_onSelect);
    on<EditCaptionEvent>(_onEdit);
    on<UnSelectImageEvent>(_onUnSelect);
    on<SubmitEvent>(_onSubmit);
  }

  Future<void> _onInit(InitEvent event, Emitter<CreateFeedState> emit) async {
    emit(state.copyWith(
        status: event.status, message: event.message, content: event.content));
  }

  Future<void> _onTap(
      OnTapImageEvent event, Emitter<CreateFeedState> emit) async {
    emit(state.copyWith(currentImage: event.asset));
  }

  Future<void> _onAsk(
      AskPermissionEvent event, Emitter<CreateFeedState> emit) async {
    try {
      emit(state.copyWith(status: Status.loading));
      final isAuth = await PhotoManager.requestPermissionExtend()
          .then((res) => res.isAuth);
      logger.t('permitted:$isAuth');
      emit(state.copyWith(isAuth: isAuth, status: Status.initial));
    } catch (error) {
      logger.e(error);
      emit(state.copyWith(status: Status.error, message: 'error occurs'));
    }
  }

  Future<void> _onSelect(
      SelectImageEvent event, Emitter<CreateFeedState> emit) async {
    try {
      emit(state.copyWith(
          selected: [...state.selected, event.asset],
          captions: [...state.captions, '']));
    } catch (error) {
      logger.e(error);
      emit(state.copyWith(status: Status.error, message: 'error occurs'));
    }
  }

  Future<void> _onEdit(
      EditCaptionEvent event, Emitter<CreateFeedState> emit) async {
    try {
      emit(state.copyWith(
          captions: List.generate(
              state.captions.length,
              (index) => index == event.index
                  ? event.content
                  : state.captions[index])));
    } catch (error) {
      logger.e(error);
      emit(state.copyWith(status: Status.error, message: 'error occurs'));
    }
  }

  Future<void> _onUnSelect(
      UnSelectImageEvent event, Emitter<CreateFeedState> emit) async {
    try {
      List<AssetEntity> selected = [...state.selected];
      List<String> captions = [...state.captions];
      selected.removeAt(event.index);
      captions.removeAt(event.index);
      emit(state.copyWith(selected: selected, captions: captions));
    } catch (error) {
      logger.e(error);
      emit(state.copyWith(status: Status.error, message: 'error occurs'));
    }
  }

  Future<void> _onMount(
      OnMountEvent event, Emitter<CreateFeedState> emit) async {
    try {
      emit(state.copyWith(status: Status.loading));
      // 권한 검사하기
      final isAuth = await PhotoManager.requestPermissionExtend()
          .then((res) => res.isAuth);
      if (!isAuth) {
        emit(state.copyWith(
            isAuth: false, status: Status.error, message: 'permission denied'));
        return;
      }
      // 앨범 가져오기
      await PhotoManager.getAssetPathList(
              hasAll: true,
              onlyAll: false,
              type: RequestType.image,
              filterOption: FilterOptionGroup(
                  imageOption: const FilterOption(
                      sizeConstraint: SizeConstraint(maxWidth: 10000))))
          .then(
              (res) => emit(state.copyWith(album: res, assetPath: res.first)));
      // assets 가져오기
      await state.assetPath!.getAssetListPaged(page: 0, size: 100).then(
          (res) => emit(state.copyWith(assets: res, currentImage: res.first)));
      emit(state.copyWith(status: Status.initial, isAuth: true));
    } catch (error) {
      logger.e(error);
      emit(state.copyWith(
          status: Status.error, message: 'error occurs on submitting'));
    }
  }

  Future<void> _onSubmit(
      SubmitEvent event, Emitter<CreateFeedState> emit) async {
    try {
      emit(state.copyWith(status: Status.loading));
      await _useCase
          .create(
              id: state.id,
              content: state.content,
              hashtags: state.hashtags,
              captions: state.captions,
              images: state.selected.isEmpty
                  ? []
                  : await Future.wait(state.selected
                      .map((item) async => (await item.originFile as File))))
          .then((res) => res.fold(
              (l) => emit(
                  state.copyWith(status: Status.error, message: l.message)),
              (r) => emit(state.copyWith(status: Status.success))));
    } catch (error) {
      logger.e(error);
      emit(state.copyWith(
          status: Status.error, message: 'error occurs on submitting'));
    }
  }
}
