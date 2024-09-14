import 'dart:developer';
import 'dart:io';

import 'package:flutter_app/shared/constant/constant.export.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:uuid/uuid.dart';

import '../../../../feed/feed.export.dart';
import '../../../../shared/constant/enums/error_code.enum.dart';
import '../../../constant/constant.dart';

part 'create_feed.state.dart';

part 'create_feed.event.dart';

@injectable
class CreateFeedBloc extends Bloc<CreateFeedEvent, CreateFeedState> {
  final FeedUseCase _useCase;

  CreateFeedBloc(this._useCase)
      : super(CreateFeedState(
            id: const Uuid().v4(), hashtags: [], albums: [], assets: [])) {
    on<FetchAlbumsEvent>(_onFetchAlbums);
    on<SelectAlbumEvent>(_onSelectAlbum);
    on<SelectAssetEvent>(_onSelectAsset);
    on<FetchMoreAssetsEvent>(_onFetchMoreAssets);
    on<UpdateStateEvent>(_onUpdateState);
    on<UploadEvent>(_onUpload);
  }

  Future<void> _onFetchAlbums(
      FetchAlbumsEvent event, Emitter<CreateFeedState> emit) async {
    try {
      emit(state.copyWith(status: Status.loading));
      final isAuth = await PhotoManager.requestPermissionExtend()
          .then((res) => res.isAuth);
      if (!isAuth) {
        throw CustomException(ErrorCode.permissionError,
            message: '권한이 허용되지 않았습니다');
      }
      emit(state.copyWith(
          status: isAuth ? Status.success : Status.error,
          isAuth: isAuth,
          errorMessage: isAuth ? null : '디바이스 접근 권한 오류가 발생했습니다'));

      final albums = await PhotoManager.getAssetPathList(
          type: RequestType.image,
          filterOption: FilterOptionGroup(
              imageOption: FilterOption(
                  sizeConstraint: SizeConstraint(minHeight: event.minHeight)),
              orders: [
                const OrderOption(type: OrderOptionType.createDate, asc: false)
              ]));
      final assets =
          await albums.first.getAssetListRange(start: 0, end: event.take);
      emit(state.copyWith(
          isAuth: true,
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
      if (state.currentAlbum == event.album || !state.isAuth) return;
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
      SelectAssetEvent event, Emitter<CreateFeedState> emit) async {
    try {
      if (state.currentAsset == event.asset || !state.isAuth) return;
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
            step: CreateMediaStep.uploading,
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
          step: res.ok ? CreateMediaStep.uploading : CreateMediaStep.detail,
          status: res.ok ? Status.success : Status.error,
          errorMessage: res.ok ? null : res.message));
    } catch (error) {
      emit(state.copyWith(
          status: Status.error, errorMessage: '피드 업로드 중 오류가 발생했습니다'));
    }
  }
}
