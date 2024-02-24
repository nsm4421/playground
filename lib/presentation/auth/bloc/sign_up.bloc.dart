import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hot_place/presentation/auth/bloc/sign_up.event.dart';
import 'package:hot_place/presentation/auth/bloc/sign_up.state.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import '../../../domain/usecase/credential/google_sign_up.usecase.dart';


@injectable
class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final GoogleSignUpUseCase googleSignUpUseCase;

  final _logger = Logger();

  SignUpBloc({required this.googleSignUpUseCase}) : super(const SignUpState()) {
    on<InitSignUpEvent>(_onInit);
    on<GoogleSignUpEvent>(_googleSignUp);
  }

  Future<void> _onInit(
    InitSignUpEvent event,
    Emitter<SignUpState> emit,
  ) async {
    try {
      emit(state.copyWith(isDone: false, isLoading: false, isError: false));
    } catch (err) {
      emit(state.copyWith(isDone: false, isLoading: false, isError: true));
      _logger.e(err);
    }
  }

  Future<void> _googleSignUp(
    GoogleSignUpEvent event,
    Emitter<SignUpState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));
      await googleSignUpUseCase();
      emit(state.copyWith(isDone: true));
    } catch (err) {
      emit(state.copyWith(isError: true));
      _logger.e(err);
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }
}
