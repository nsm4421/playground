part of '../export.bloc.dart';

@injectable
class SelectMediaCubit extends Cubit<SelectMediaState> with LoggerUtil {
  final RequestType _type;
  static const int _pageSize = 20;

  SelectMediaCubit(@factoryParam this._type)
      : super(SelectMediaState(type: _type));

  onInit() async {
    emit(state.copyWith(status: Status.loading));
    try {
      // 권한 체크하기
      final isAuth = await PhotoManager.requestPermissionExtend()
          .then((res) => res.isAuth);
      emit(state.copyWith(isAuth: isAuth));
      if (!isAuth) {
        await PhotoManager.openSetting();
        emit(state.copyWith(status: Status.initial));
        return;
      }

      // 앨범 목록 찾기
      final albums = await PhotoManager.getAssetPathList(
        type: _type,
      );
      emit(state.copyWith(albums: albums));

      // 만약 선택할 앨범 목록이 없는 경우
      if (albums.isEmpty) {
        emit(state.copyWith(
            status: Status.error, errorMessage: 'no album founded'));
        return;
      }

      // asset 목록 찾기
      final assets =
          await albums.first.getAssetListPaged(page: 0, size: _pageSize);
      emit(state.copyWith(
          mounted: true,
          status: Status.success,
          assets: assets,
          selected: [assets.first],
          isEnd: assets.length < _pageSize));
    } catch (error) {
      emit(state.copyWith(
          status: Status.error, errorMessage: 'initialization fails'));
      logger.e(error);
    }
  }

  switchAlbum(int index) async {
    if (index < 0 ||
        index >= state.albums.length ||
        index == state.albumIndex) {
      return;
    }
    emit(state.copyWith(status: Status.loading));
    try {
      final assets =
          await state.albums[index].getAssetListPaged(page: 0, size: _pageSize);
      emit(state.copyWith(
          status: Status.success,
          albumIndex: index,
          assets: assets,
          page: 0,
          isEnd: assets.length < _pageSize));
    } catch (error) {
      emit(state.copyWith(
          status: Status.error, errorMessage: 'switching album fails'));
      logger.e(error);
    }
  }

  selectAsset(AssetEntity asset) {
    final isDuplicated =
        state.selected.map((item) => item.id).contains(asset.id);
    if (!isDuplicated) {
      emit(state.copyWith(selected: [...state.selected, asset]));
    }
  }

  unSelectAsset(AssetEntity asset) {
    if (state.selected.length > 1) {
      emit(state.copyWith(
          selected:
              state.selected.where((item) => item.id != asset.id).toList()));
    }
  }

 fetchMoreAssets() async {
    if (state.isEnd) {
      return;
    }
    emit(state.copyWith(status: Status.loading));
    try {
      final assets = await state.currentAlbum
          .getAssetListPaged(page: state.page + 1, size: _pageSize);
      emit(state.copyWith(
          status: Status.success,
          assets: [...state.assets, ...assets],
          page: state.page + 1,
          isEnd: assets.length < _pageSize));
    } catch (error) {
      emit(state.copyWith(
          status: Status.error, errorMessage: 'fetching more asset fails'));
      logger.e(error);
    }
  }
}
