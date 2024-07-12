import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hot_place/core/constant/user.constant.dart';
import 'package:hot_place/domain/usecase/user/user.usecase.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/constant/response.constant.dart';
import 'search_user.state.dart';

@lazySingleton
class SearchUserCubit extends Cubit<SearchUserState> {
  SearchUserCubit(this._useCase) : super(const SearchUserState());

  final UserUseCase _useCase;

  void init() {
    try {
      emit(const SearchUserState());
    } catch (err) {
      emit(state.copyWith(
          status: Status.error, errorMessage: '알수 없는 오류가 발생했습니다'));
    }
  }

  void switchType(UserSearchType type) {
    try {
      emit(state.copyWith(type: type));
    } catch (err) {
      emit(state.copyWith(
          status: Status.error, errorMessage: '알수 없는 오류가 발생했습니다'));
    }
  }

  void searchUsers(
      {required UserSearchType type, required String keyword}) async {
    try {
      emit(state.copyWith(status: Status.loading));
      final res = await _useCase.searchUser(type: type, keyword: keyword);
      res.fold(
          (l) => emit(state.copyWith(
              status: Status.error,
              errorMessage: l.message ?? '유저 검색 중 오류가 발생했습니다')),
          (r) => emit(state.copyWith(
              status: Status.success, type: type, keyword: keyword, users: r)));
    } catch (err) {
      emit(state.copyWith(
          status: Status.error, errorMessage: '알수 없는 오류가 발생했습니다'));
    }
  }
}
