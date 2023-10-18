import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/presentation/features/home/bloc/swipe/swipe.event.dart';
import 'package:my_app/presentation/features/home/bloc/swipe/swipe.state.dart';

import '../../../../../core/constant/status.enum.dart';
import '../../../../../core/util/logger.dart';
import '../../../../../model/user/user.model.dart';

class SwipeBloc extends Bloc<SwipeEvent, SwipeState> {
  SwipeBloc() : super(const SwipeState(status: Status.initial, users: [])) {
    on<SwipeInitEvent>(_onSwipeInitialized);
    on<SwipeLeftEvent>(_onSwipedLeft);
    on<SwipeRightEvent>(_onSwipedRight);
  }

  // TODO : Get More User
  Future<UserModel> _loadNewUser() async => const UserModel(
      nickname: "Karma",
      age: 30,
      height: 180,
      profileImageUrl: "https://image.yes24.com/goods/108390086/XL",
      imageUrls: [
        "https://image.yes24.com/goods/108390086/XL",
        "https://thumb.mt.co.kr/06/2023/07/2023070410355539719_1.jpg/dims/optimize/"
      ],
      introduce: "안녕하세요~! \n 노량진 사는 ~~입니다");

  Future<void> _onSwipeInitialized(
    SwipeEvent event,
    Emitter<SwipeState> emit,
  ) async {
    try {
      emit(state.copyWith(status: Status.loading));
      emit(state.copyWith(status: Status.success, users: [
        await _loadNewUser(),
        await _loadNewUser(),
        await _loadNewUser(),
        await _loadNewUser(),
      ]));
    } catch (e) {
      CustomLogger.logger.e(e);
      emit(state.copyWith(status: Status.error));
    }
  }

  Future<void> _onSwipedLeft(
    SwipeLeftEvent event,
    Emitter<SwipeState> emit,
  ) async {
    try {
      emit(state.copyWith(status: Status.loading));
      emit(state.copyWith(
          status: Status.success,
          users: List.from(state.users)
            ..remove(event.user)
            ..add(await _loadNewUser())));
    } catch (e) {
      CustomLogger.logger.e(e);
      emit(state.copyWith(status: Status.error));
    }
  }

  Future<void> _onSwipedRight(
    SwipeRightEvent event,
    Emitter<SwipeState> emit,
  ) async {
    try {
      emit(state.copyWith(status: Status.loading));
      emit(state.copyWith(
          status: Status.success,
          users: List.from(state.users)
            ..remove(event.user)
            ..add(await _loadNewUser())));
    } catch (e) {
      CustomLogger.logger.e(e);
      emit(
        state.copyWith(status: Status.error),
      );
    }
  }
}
