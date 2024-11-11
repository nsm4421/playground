import 'package:injectable/injectable.dart';
import 'package:travel/domain/usecase/module.dart';
import 'package:travel/presentation/bloc/auth/presence/bloc.dart';
import 'package:travel/presentation/bloc/auth/sign_in/cubit.dart';
import 'package:travel/presentation/bloc/bottom_nav/cubit.dart';
import 'package:travel/presentation/bloc/feed/create/bloc.dart';
import 'package:travel/presentation/bloc/feed/display/bloc.dart';

import 'auth/sign_up/cubit.dart';

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

  /// create media
  @lazySingleton
  DisplayFeedBloc get displayFeed => DisplayFeedBloc(_useCase.feed);

  @lazySingleton
  CreateFeedBloc get createFeed => CreateFeedBloc(_useCase.feed);
}
