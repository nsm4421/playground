import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/domain/model/feed/feed.model.dart';
import 'package:my_app/screen/home/search/bloc/search.event.dart';
import 'package:my_app/screen/home/search/bloc/search.state.dart';
import 'package:my_app/usecase/auth/auth.usecase.dart';
import 'package:my_app/usecase/auth/search_user.usecase.dart';
import 'package:my_app/usecase/feed/search_feed.usecase.dart';
import '../../../../core/constant/feed.enum.dart';
import '../../../../core/response/response.dart';
import '../../../../domain/model/user/user.model.dart';
import '../../../../usecase/feed/feed.usecase.dart';

@injectable
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final AuthUsecase authUsecase;
  final FeedUsecase feedUsecase;

  SearchBloc({required this.authUsecase, required this.feedUsecase})
      : super(const SearchState()) {
    on<InitSearchEvent>(_onInit);
    on<SearchFeedEvent>(_onSearchFeed);
    on<SearchUserEvent>(_onSearchUser);
  }

  void _onInit(InitSearchEvent event, Emitter<SearchState> emit) {
    emit(state.copyWith(status: SearchStatus.initial));
  }

  void _onSearchFeed(SearchFeedEvent event, Emitter<SearchState> emit) async {
    try {
      emit(state.copyWith(
          status: SearchStatus.loading,
          option: event.option ?? state.option,
          keyword: event.keyword ?? state.keyword));
      final Response<List<FeedModel>> response = await feedUsecase.execute(
          useCase: SearchFeedUsecase(
              option: event.option ?? state.option, keyword: state.keyword));
      response.status == Status.success
          ? emit(state.copyWith(
              status: SearchStatus.success, feeds: response.data ?? []))
          : emit(state.copyWith(status: SearchStatus.error));
    } catch (err) {
      emit(state.copyWith(status: SearchStatus.error));
      debugPrint(err.toString());
    }
  }

  void _onSearchUser(SearchUserEvent event, Emitter<SearchState> emit) async {
    try {
      emit(state.copyWith(
          status: SearchStatus.loading,
          option: SearchOption.nickname,
          keyword: event.keyword ?? state.keyword));
      final Response<List<UserModel>> response = await authUsecase.execute(
          useCase: SearchUserByNicknameUsecase(state.keyword));
      response.status == Status.success
          ? emit(state.copyWith(
              status: SearchStatus.success, users: response.data ?? []))
          : emit(state.copyWith(status: SearchStatus.error));
    } catch (err) {
      emit(state.copyWith(status: SearchStatus.error));
      debugPrint(err.toString());
    }
  }
}
