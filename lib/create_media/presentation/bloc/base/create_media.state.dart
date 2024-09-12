part of 'create_media.cubit.dart';

class CreateMediaState {
  final CreateMediaMode mode;
  final CreateMediaStep step;

  CreateMediaState({required this.mode, required this.step});

  CreateMediaState copyWith({CreateMediaMode? mode, CreateMediaStep? step}) {
    return CreateMediaState(mode: mode ?? this.mode, step: step ?? this.step);
  }
}
