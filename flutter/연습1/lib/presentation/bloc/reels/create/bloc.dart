import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:travel/core/abstract/abstract.dart';
import 'package:travel/core/constant/constant.dart';
import 'package:travel/core/util/extension/extension.dart';
import 'package:travel/core/util/logger/logger.dart';
import 'package:travel/domain/usecase/reels/usecase.dart';
import 'package:uuid/uuid.dart';

part 'state.dart';

part 'event.dart';

class CreateReelsBloc extends Bloc<CreateReelsEvent, CreateReelsState>
    with CustomLogger {
  static final Duration _maxDuration = 3.min;
  final ReelsUseCase _useCase;

  CreateReelsBloc(this._useCase)
      : super(CreateReelsState(id: const Uuid().v4())) {
    on<InitEvent>(_onInit);
    on<AskPermissionEvent>(_onAsk);
    on<OnMountEvent>(_onMount);
    on<SelectVideoEvent>(_onSelect);
    on<FetchMoreAssetEvent>(_onFetch);
    on<ChangeAssetPathEvent>(_onChangePath);
    on<EditCaptionEvent>(_onEdit);
    on<SubmitEvent>(_onSubmit);
  }

  Future<void> _onInit(InitEvent event, Emitter<CreateReelsState> emit) async {
    emit(state.copyWith(
        status: event.status, message: event.message, caption: event.caption));
  }

  Future<void> _onAsk(
      AskPermissionEvent event, Emitter<CreateReelsState> emit) async {
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
      SelectVideoEvent event, Emitter<CreateReelsState> emit) async {
    try {
      emit(state.copyWith(video: event.video));
    } catch (error) {
      logger.e(error);
      emit(state.copyWith(status: Status.error, message: 'error occurs'));
    }
  }

  Future<void> _onEdit(
      EditCaptionEvent event, Emitter<CreateReelsState> emit) async {
    try {
      emit(state.copyWith(caption: event.caption));
    } catch (error) {
      logger.e(error);
      emit(state.copyWith(status: Status.error, message: 'error occurs'));
    }
  }

  Future<void> _onChangePath(
      ChangeAssetPathEvent event, Emitter<CreateReelsState> emit) async {
    try {
      if (event.assetPath == state.currentAssetPath) return;
      emit(state.copyWith(status: Status.loading, assetPath: event.assetPath));
      final assets =
          await state.currentAssetPath!.getAssetListPaged(page: 0, size: 100);
      await Future.delayed(500.ms, () async {
        emit(state.copyWith(
            assets: assets, video: assets.first, status: Status.initial));
      });
    } catch (error) {
      logger.e(error);
      emit(state.copyWith(status: Status.error, message: 'error occurs'));
    }
  }

  Future<void> _onFetch(
      FetchMoreAssetEvent event, Emitter<CreateReelsState> emit) async {
    try {
      emit(state.copyWith(status: Status.loading));
      final fetched = await state.currentAssetPath!.getAssetListRange(
          start: state.assets.length, end: state.assets.length + event.take);
      await Future.delayed(500.ms, () async {
        emit(state.copyWith(
            assets: [...state.assets, ...fetched],
            status: Status.initial,
            isEnd: fetched.length < event.take));
      });
    } catch (error) {
      logger.e(error);
      emit(state.copyWith(status: Status.error, message: 'error occurs'));
    }
  }

  Future<void> _onMount(
      OnMountEvent event, Emitter<CreateReelsState> emit) async {
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
              type: RequestType.video,
              filterOption: FilterOptionGroup(
                  videoOption: FilterOption(
                      durationConstraint:
                          DurationConstraint(max: _maxDuration))))
          .then(
              (res) => emit(state.copyWith(album: res, assetPath: res.first)));
      // assets 가져오기
      await state.currentAssetPath!
          .getAssetListPaged(page: 0, size: event.take)
          .then((fetched) async => emit(state.copyWith(
              assets: fetched,
              video: fetched.first,
              isEnd: fetched.length < event.take)));
      emit(state.copyWith(status: Status.initial, isAuth: true));
    } catch (error) {
      logger.e(error);
      emit(state.copyWith(
          status: Status.error, message: 'error occurs on mounting'));
    }
  }

  Future<void> _onSubmit(
      SubmitEvent event, Emitter<CreateReelsState> emit) async {
    try {
      emit(state.copyWith(status: Status.loading));
      if (state.caption.isEmpty) {
        emit(state.copyWith(
            status: Status.error, message: 'caption is not given'));
      } else {
        await _useCase
            .create(
                id: state.id,
                caption: state.caption,
                video: (await state.video!.file) as File)
            .then((res) => res.fold(
                (l) => emit(
                    state.copyWith(status: Status.error, message: l.message)),
                (r) => emit(state.copyWith(status: Status.success))));
      }
    } catch (error) {
      logger.e(error);
      emit(state.copyWith(
          status: Status.error, message: 'error occurs on submitting'));
    }
  }
}
