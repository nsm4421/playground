import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../../constant/constant.dart';

part 'create_media.state.dart';

@lazySingleton
class CreateMediaCubit extends Cubit<CreateMediaState> {
  CreateMediaCubit()
      : super(CreateMediaState(
            mode: CreateMediaMode.feed, step: CreateMediaStep.selectMedia));

  switchStep(CreateMediaStep step) {
    emit(state.copyWith(step: step));
  }

  switchMode(CreateMediaMode mode) {
    emit(state.copyWith(mode: mode));
  }

  askPermission() async {
    emit(state.copyWith(mounted: false));
    final isAuth =
        await PhotoManager.requestPermissionExtend().then((res) => res.isAuth);
    emit(state.copyWith(isAuth: isAuth, mounted: true));
  }
}
