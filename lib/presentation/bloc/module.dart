import 'package:injectable/injectable.dart';
import 'package:travel/domain/entity/feed/feed.dart';
import 'package:travel/domain/entity/reels/reels.dart';
import 'package:travel/domain/usecase/module.dart';
import 'package:travel/presentation/bloc/auth/presence/bloc.dart';
import 'package:travel/presentation/bloc/auth/sign_in/cubit.dart';
import 'package:travel/presentation/bloc/auth/sign_up/cubit.dart';
import 'package:travel/presentation/bloc/bottom_nav/cubit.dart';
import 'package:travel/presentation/bloc/comment/create/cubit.dart';
import 'package:travel/presentation/bloc/comment/display/bloc.dart';
import 'package:travel/presentation/bloc/emotion/cubit.dart';
import 'package:travel/presentation/bloc/feed/create/bloc.dart';
import 'package:travel/presentation/bloc/feed/display/bloc.dart';
import 'package:travel/presentation/bloc/feed/search/bloc.dart';
import 'package:travel/presentation/bloc/reels/create/bloc.dart';
import 'package:travel/presentation/bloc/reels/display/bloc.dart';

@lazySingleton
class BlocModule {
  final UseCaseModule _useCase;

  BlocModule(this._useCase);

  /// auth
  @injectable
  SignInCubit get signIn => SignInCubit(_useCase.auth);

  @injectable
  SignUpCubit get signUp => SignUpCubit(_useCase.auth);

  @lazySingleton
  AuthenticationBloc get auth => AuthenticationBloc(_useCase.auth);

  /// nav
  @lazySingleton
  HomeBottomNavCubit get homeBottomNav => HomeBottomNavCubit();

  /// feed
  @lazySingleton
  DisplayFeedBloc get displayFeed => DisplayFeedBloc(_useCase.feed);

  @lazySingleton
  CreateFeedBloc get createFeed => CreateFeedBloc(_useCase.feed);

  @lazySingleton
  SearchFeedBloc get searchFeed => SearchFeedBloc(_useCase.feed);

  @injectable
  EmotionCubit<FeedEntity> feedEmotion(FeedEntity feed) =>
      EmotionCubit<FeedEntity>(feed, useCase: _useCase.emotion);

  @injectable
  CreateCommentCubit<FeedEntity> createFeedComment(FeedEntity feed) =>
      CreateCommentCubit<FeedEntity>(feed, useCase: _useCase.comment);

  @injectable
  DisplayCommentBloc<FeedEntity> displayFeedComment(FeedEntity feed) =>
      DisplayCommentBloc<FeedEntity>(feed, useCase: _useCase.comment);

  /// reels
  @lazySingleton
  DisplayReelsBloc get displayReels => DisplayReelsBloc(_useCase.reels);

  @lazySingleton
  CreateReelsBloc get createReels => CreateReelsBloc(_useCase.reels);

  @injectable
  EmotionCubit<ReelsEntity> reelsEmotion(ReelsEntity feed) =>
      EmotionCubit<ReelsEntity>(feed, useCase: _useCase.emotion);

  @injectable
  DisplayCommentBloc<ReelsEntity> displayReelsComment(ReelsEntity reels) =>
      DisplayCommentBloc<ReelsEntity>(reels, useCase: _useCase.comment);

  @injectable
  CreateCommentCubit<ReelsEntity> createReelsComment(ReelsEntity reels) =>
      CreateCommentCubit<ReelsEntity>(reels, useCase: _useCase.comment);
}
