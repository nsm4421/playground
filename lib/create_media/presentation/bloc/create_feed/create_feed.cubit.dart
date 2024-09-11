import 'dart:developer';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:uuid/uuid.dart';

import '../../../../feed/feed.export.dart';
import '../../../../shared/shared.export.dart';
import '../base/base.state.dart';

part 'create_feed.state.dart';

@injectable
class CreateFeedCubit extends Cubit<CreateFeedState> {
  final FeedUseCase _useCase;

  CreateFeedCubit(this._useCase)
      : super(CreateFeedState(
            id: const Uuid().v4(), hashtags: [], albums: [], assets: []));

  reset({CreateStep? step, Status status = Status.initial}) {
    emit(state.copyWith(step: step ?? state.step, status: status));
  }

  askPermission() async {
    final permission = await PhotoManager.requestPermissionExtend();
    if (permission.isAuth) {
      emit(state.copyWith(status: Status.success, isAuth: true));
    } else {
      emit(state.copyWith(
          status: Status.error,
          isAuth: false,
          errorMessage: '디바이스 접근이 거부되었습니다'));
    }
  }

  fetchAlbums({int minHeight = 100, int take = 20}) async {
    try {
      await askPermission();
      emit(state.copyWith(status: Status.loading));
      final albums = await PhotoManager.getAssetPathList(
          type: RequestType.image,
          filterOption: FilterOptionGroup(
              imageOption: FilterOption(
                  sizeConstraint: SizeConstraint(minHeight: minHeight)),
              orders: [
                const OrderOption(type: OrderOptionType.createDate, asc: false)
              ]));
      final assets = await albums.first.getAssetListRange(start: 0, end: take);
      emit(state.copyWith(
          albums: albums,
          currentAlbum: albums.first,
          assets: assets,
          isEnd: assets.length < take));
      await selectAsset(assets[0]);
    } catch (error) {
      log(error.toString());
      emit(state.copyWith(
          status: Status.error, errorMessage: '이미지를 가져오는 중 오류가 발생했습니다'));
    }
  }

  selectAlbum(AssetPathEntity album, {int take = 20}) async {
    if (album == state.currentAlbum) {
      return;
    }
    try {
      emit(state.copyWith(status: Status.loading));
      final assets = await album.getAssetListPaged(page: 0, size: take);
      emit(state.copyWith(
          currentAlbum: album, assets: assets, isEnd: assets.length < take));
      await selectAsset(assets.first);
      emit(state.copyWith(status: Status.success));
    } catch (error) {
      log(error.toString());
      emit(state.copyWith(
          status: Status.error, errorMessage: '앨범을 선택하는 중 오류가 발생해습니다'));
    }
  }

  selectAsset(AssetEntity asset) async {
    if (asset == state.currentAsset) {
      return;
    }
    try {
      emit(state.copyWith(status: Status.loading));
      final file = await asset.file;
      if (file == null) {
        return;
      }
      emit(state.copyWith(
          media: file, currentAsset: asset, status: Status.success));
    } catch (error) {
      log(error.toString());
      emit(state.copyWith(
          status: Status.error, errorMessage: '이미지를 선택하는 중 오류가 발생해습니다'));
    }
  }

  fetchAssets({int take = 20}) async {
    if (state.currentAlbum == null) {
      return;
    }
    try {
      emit(state.copyWith(status: Status.loading));
      final fetched = await state.currentAlbum!.getAssetListRange(
          start: state.assets.length, end: state.assets.length + take);
      emit(state.copyWith(
          assets: [...state.assets, ...fetched],
          isEnd: fetched.length < take,
          status: Status.success));
    } catch (error) {
      log(error.toString());
      emit(state.copyWith(
          status: Status.error, errorMessage: '이미지를 가져오는 오류가 발생해습니다'));
    }
  }

  movePage(CreateStep step) {
    if (step != state.step) {
      emit(state.copyWith(step: step));
    }
  }

  updateCaption(String text) {
    emit(state.copyWith(caption: text));
  }

  updateHashtags(List<String> hashtags) {
    emit(state.copyWith(hashtags: hashtags));
  }

  uploadFeed() async {
    try {
      emit(state.copyWith(status: Status.loading));
      if (state.media == null || state.caption.isEmpty) {
        emit(state.copyWith(
            step: CreateStep.uploading,
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
          status: res.ok ? Status.success : Status.error,
          errorMessage: res.ok ? null : res.message));
    } catch (error) {
      log(error.toString());
      emit(state.copyWith(
          status: Status.error, errorMessage: '피드 업로드 중 오류가 발생했습니다'));
    }
  }
}
