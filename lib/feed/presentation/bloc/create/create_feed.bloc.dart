import 'dart:developer';
import 'dart:io';

import 'package:flutter_app/shared/constant/constant.export.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:uuid/uuid.dart';

import '../../../feed.export.dart';

part 'create_feed.state.dart';

part 'create_feed.event.dart';

@injectable
class CreateFeedBloc extends Bloc<CreateFeedEvent, CreateFeedState> {
  final FeedUseCase _useCase;

  CreateFeedBloc(this._useCase) : super(CreateFeedState()) {
    on<AskPermissionEvent>(_onAskPermission);
    on<FetchAlbumsEvent>(_onFetchAlbums);
    on<SelectAlbumEvent>(_onSelectAlbum);
    on<SelectAssetEvent>(_onSelectAsset);
    on<FetchMoreAssetsEvent>(_onFetchMoreAssets);
    on<UpdateStateEvent>(_onUpdateState);
    on<UploadEvent>(_onUpload);
  }

  Future<void> _onAskPermission(
      AskPermissionEvent event, Emitter<CreateFeedState> emit) async {
    try {
      log('[CreateFeedBloc]_onAskPermission실행');
      emit(state.copyWith(status: Status.loading));
      final isAuth = await PhotoManager.requestPermissionExtend()
          .then((res) => res.isAuth);
      log('[CreateFeedBloc]권한 여부 : $isAuth');
      emit(state.copyWith(
          step:
              isAuth ? CreateMediaStep.selectMedia : CreateMediaStep.permission,
          status: isAuth ? Status.success : Status.error));
    } catch (error) {
      emit(state.copyWith(
          status: Status.error,
          errorMessage:
              error is CustomException ? error.message : '알수 없는 오류가 발생하였습니다'));
    }
  }

  Future<void> _onFetchAlbums(
      FetchAlbumsEvent event, Emitter<CreateFeedState> emit) async {
    try {
      log('[CreateFeedBloc]_onFetchAlbums실행');
      emit(state.copyWith(status: Status.loading));
      final albums = await PhotoManager.getAssetPathList(
          type: RequestType.common,
          filterOption: FilterOptionGroup(
              imageOption: FilterOption(
                  sizeConstraint: SizeConstraint(minHeight: event.minHeight)),
              orders: [
                const OrderOption(type: OrderOptionType.createDate, asc: false)
              ]));
      log('[CreateFeedBloc]앨범 ${albums.length}개 가져옴');
      final assets =
          await albums.first.getAssetListRange(start: 0, end: event.take);
      log('[CreateFeedBloc]asset ${assets.length}개 가져옴');
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
      SelectAlbumEvent event, Emitter<CreateFeedState> emit) async {
    try {
      log('[CreateFeedBloc]_onSelectAlbum실행');
      if (state.currentAlbum == event.album) return;
      emit(state.copyWith(status: Status.loading, currentAlbum: event.album));
      final assets = await state.currentAlbum!
          .getAssetListRange(start: 0, end: event.take);
      log('[CreateFeedBloc]asset ${assets.length}개 가져옴');
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
      SelectAssetEvent event, Emitter<CreateFeedState> emit) async {
    try {
      if (state.currentAsset == event.asset) return;
      emit(state.copyWith(
          media: await event.asset.file, currentAsset: event.asset));
    } catch (error) {
      log(error.toString());
    }
  }

  Future<void> _onFetchMoreAssets(
      FetchMoreAssetsEvent event, Emitter<CreateFeedState> emit) async {
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
      UpdateStateEvent event, Emitter<CreateFeedState> emit) async {
    emit(state.copyWith(
        id: event.id ?? state.id,
        status: event.status ?? state.status,
        caption: event.caption ?? state.caption,
        hashtags: event.hashtags ?? state.hashtags,
        step: event.step ?? state.step));
  }

  Future<void> _onUpload(
      UploadEvent event, Emitter<CreateFeedState> emit) async {
    try {
      emit(state.copyWith(status: Status.loading));
      if (state.media == null || state.caption.isEmpty) {
        emit(state.copyWith(
            step: CreateMediaStep.detail,
            status: Status.error,
            errorMessage: '사진이나 캡션을 다시 확인해주세요'));
        return;
      }
      final res = await _useCase.createFeed(
          feedId: state.id,
          feedImage: state.media!,
          caption: state.caption,
          hashtags: state.hashtags);
      emit(state.copyWith(
          step: res.ok ? CreateMediaStep.done : CreateMediaStep.detail,
          status: res.ok ? Status.success : Status.error,
          errorMessage: res.ok ? null : res.message));
    } catch (error) {
      emit(state.copyWith(
          status: Status.error, errorMessage: '피드 업로드 중 오류가 발생했습니다'));
    }
  }
}
