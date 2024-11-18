import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:travel/core/abstract/abstract.dart';
import 'package:travel/core/constant/constant.dart';
import 'package:travel/core/util/extension/extension.dart';
import 'package:travel/core/util/logger/logger.dart';
import 'package:travel/domain/usecase/feed/usecase.dart';
import 'package:uuid/uuid.dart';

part 'state.dart';

part 'event.dart';

class CreateFeedBloc extends Bloc<CreateFeedEvent, CreateFeedState>
    with CustomLogger {
  final FeedUseCase _useCase;

  static const int _maxImageNum = 5;

  int get maxImageNum => _maxImageNum;

  CreateFeedBloc(this._useCase)
      : super(CreateFeedState(id: const Uuid().v4())) {
    on<InitEvent>(_onInit);
    on<AskPermissionEvent>(_onAsk);
    on<OnMountEvent>(_onMount);
    on<OnTapImageEvent>(_onTap);
    on<EditCaptionEvent>(_onEdit);
    on<ChangeAssetPathEvent>(_onChangePath);
    on<FetchMoreAssetEvent>(_onFetch);
    on<SelectImageEvent>(_onSelect);
    on<UnSelectImageEvent>(_onUnSelect);
    on<SubmitEvent>(_onSubmit);
  }

  Future<void> _onInit(InitEvent event, Emitter<CreateFeedState> emit) async {
    emit(state.copyWith(
        status: event.status,
        message: event.message,
        hashtags: event.hashtags));
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
      if (state.images.length >= _maxImageNum) {
        emit(state.copyWith(
            status: Status.error,
            message: "the number of image can't exceed $_maxImageNum}"));
      } else {
        emit(state.copyWith(
            selected: [...state.images, event.asset],
            captions: [...state.captions, '']));
      }
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
              (index) => index == state.index
                  ? event.caption
                  : state.captions[index])));
    } catch (error) {
      logger.e(error);
      emit(state.copyWith(status: Status.error, message: 'error occurs'));
    }
  }

  Future<void> _onUnSelect(
      UnSelectImageEvent event, Emitter<CreateFeedState> emit) async {
    try {
      final temp = state.index;
      List<AssetEntity> selected = [...state.images];
      List<String> captions = [...state.captions];
      selected.removeAt(temp);
      captions.removeAt(temp);
      emit(state.copyWith(selected: selected, captions: captions));
    } catch (error) {
      logger.e(error);
      emit(state.copyWith(status: Status.error, message: 'error occurs'));
    }
  }

  Future<void> _onChangePath(
      ChangeAssetPathEvent event, Emitter<CreateFeedState> emit) async {
    try {
      if (event.assetPath == state.currentAssetPath) return;
      emit(state.copyWith(status: Status.loading, assetPath: event.assetPath));
      final assets = await state.currentAssetPath!
          .getAssetListPaged(page: 0, size: event.take);
      await Future.delayed(500.ms, () {
        emit(state.copyWith(
            assets: assets,
            currentImage: assets.first,
            status: Status.initial,
            isEnd: assets.length < event.take));
      });
    } catch (error) {
      logger.e(error);
      emit(state.copyWith(status: Status.error, message: 'error occurs'));
    }
  }

  Future<void> _onFetch(
      FetchMoreAssetEvent event, Emitter<CreateFeedState> emit) async {
    try {
      emit(state.copyWith(status: Status.loading));
      final fetched = await state.currentAssetPath!.getAssetListRange(
          start: state.assets.length, end: state.assets.length + event.take);
      await Future.delayed(500.ms, () {
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
      await state.currentAssetPath!
          .getAssetListPaged(page: 0, size: event.take)
          .then((fetched) => emit(state.copyWith(
              assets: fetched,
              currentImage: fetched.first,
              isEnd: fetched.length < event.take)));
      emit(state.copyWith(status: Status.initial, isAuth: true));
    } catch (error) {
      logger.e(error);
      emit(state.copyWith(
          status: Status.error, message: 'error occurs on mounting'));
    }
  }

  Future<void> _onSubmit(
      SubmitEvent event, Emitter<CreateFeedState> emit) async {
    try {
      if (state.images.isEmpty) {
        emit(state.copyWith(
            status: Status.error, message: 'picture is not selected'));
      } else {
        emit(state.copyWith(status: Status.loading));
        await _useCase
            .create(
                id: state.id,
                hashtags: state.hashtags,
                captions: state.captions,
                images: state.images.isEmpty
                    ? []
                    : await Future.wait(state.images
                        .map((item) async => (await item.originFile as File))))
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
