import 'dart:developer';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:uuid/uuid.dart';

import '../../../../reels/reels.export.dart';
import '../../../../shared/shared.export.dart';
import '../../../constant/constant.dart';

part 'create_reels.state.dart';

part 'create_reels.event.dart';

@injectable
class CreateReelsBloc extends Bloc<CreateReelsEvent, CreateReelsState> {
  final ReelsUseCase _useCase;

  CreateReelsBloc(this._useCase) : super(CreateReelsState()) {
    on<FetchAlbumsEvent>(_onFetchAlbums);
    on<SelectAlbumEvent>(_onSelectAlbum);
    on<SelectAssetEvent>(_onSelectAsset);
    on<FetchMoreAssetsEvent>(_onFetchMoreAssets);
    on<UpdateStateEvent>(_onUpdateState);
    on<UploadEvent>(_onUpload);
  }

  Future<void> _onFetchAlbums(
      FetchAlbumsEvent event, Emitter<CreateReelsState> emit) async {
    try {
      log('[CreateReelsBloc]_onFetchAlbums 실행');
      emit(state.copyWith(status: Status.loading));
      final albums = await PhotoManager.getAssetPathList(
          type: RequestType.video,
          filterOption: FilterOptionGroup(
              imageOption: FilterOption(
                  sizeConstraint: SizeConstraint(minHeight: event.minHeight)),
              orders: [
                const OrderOption(type: OrderOptionType.createDate, asc: false)
              ]));
      log('[CreateReelsBloc] albums ${albums.length}개 가져옴');
      final assets =
          await albums.first.getAssetListRange(start: 0, end: event.take);
      log('[CreateReelsBloc] asset ${assets.length}개 가져옴');
      emit(state.copyWith(
          albums: albums,
          currentAlbum: albums.first,
          assets: assets,
          currentAsset: assets.first,
          media: await assets.first.file,
          isEnd: assets.length < event.take,
          status: Status.success));
    } catch (error) {
      emit(state.copyWith(
          status: Status.error,
          errorMessage:
              error is CustomException ? error.message : '알수 없는 오류가 발생하였습니다'));
    }
  }

  Future<void> _onSelectAlbum(
      SelectAlbumEvent event, Emitter<CreateReelsState> emit) async {
    try {
      if (state.currentAlbum == event.album) return;
      emit(state.copyWith(status: Status.loading, currentAlbum: event.album));
      final assets = await state.currentAlbum!
          .getAssetListRange(start: 0, end: event.take);
      emit(state.copyWith(
          assets: assets,
          currentAsset: assets.first,
          media: await assets.first.file,
          isEnd: assets.length < event.take,
          status: Status.success));
    } catch (error) {
      emit(state.copyWith(
          status: Status.error,
          errorMessage:
              error is CustomException ? error.message : '알수 없는 오류가 발생하였습니다'));
    }
  }

  Future<void> _onSelectAsset(
      SelectAssetEvent event, Emitter<CreateReelsState> emit) async {
    try {
      if (state.currentAsset == event.asset) return;
      emit(state.copyWith(
          media: await event.asset.file, currentAsset: event.asset));
    } catch (error) {
      log(error.toString());
    }
  }

  Future<void> _onFetchMoreAssets(
      FetchMoreAssetsEvent event, Emitter<CreateReelsState> emit) async {
    try {
      emit(state.copyWith(status: Status.loading));
      final fetched = await state.currentAlbum!.getAssetListRange(
          start: state.assets.length, end: state.assets.length + event.take);
      emit(state.copyWith(
          assets: [...state.assets, ...fetched],
          isEnd: fetched.length < event.take,
          status: Status.success));
    } catch (error) {
      emit(state.copyWith(
          status: Status.error,
          errorMessage:
              error is CustomException ? error.message : '알수 없는 오류가 발생하였습니다'));
    }
  }

  Future<void> _onUpdateState(
      UpdateStateEvent event, Emitter<CreateReelsState> emit) async {
    emit(state.copyWith(
        status: event.status ?? state.status,
        caption: event.caption ?? state.caption,
        step: event.step ?? state.step));
  }

  Future<void> _onUpload(
      UploadEvent event, Emitter<CreateReelsState> emit) async {
    try {
      emit(state.copyWith(status: Status.loading));
      if (state.media == null || state.caption.isEmpty) {
        emit(state.copyWith(
            step: CreateMediaStep.uploading,
            status: Status.error,
            errorMessage: '릴스를 선택해주세요'));
        return;
      }
      final res = await _useCase.createReels(
          reelsId: state.id, video: state.media!, caption: state.caption);
      emit(state.copyWith(
          step: res.ok ? CreateMediaStep.uploading : CreateMediaStep.detail,
          status: res.ok ? Status.success : Status.error,
          errorMessage: res.ok ? null : res.message));
    } catch (error) {
      emit(state.copyWith(
          status: Status.error, errorMessage: '피드 업로드 중 오류가 발생했습니다'));
    }
  }
}
