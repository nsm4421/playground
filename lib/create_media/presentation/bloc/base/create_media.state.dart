part of 'create_media.cubit.dart';

class CreateMediaState {
  late final bool isAuth;
  late final bool mounted;
  final CreateMediaMode mode;
  final CreateMediaStep step;

  CreateMediaState(
      {bool? isAuth, bool? mounted, required this.mode, required this.step}) {
    this.isAuth = isAuth ?? false;
    this.mounted = mounted ?? false;
  }

  CreateMediaState copyWith(
      {bool? isAuth,
      bool? mounted,
      CreateMediaMode? mode,
      CreateMediaStep? step}) {
    return CreateMediaState(
        isAuth: isAuth ?? this.isAuth,
        mounted: mounted ?? this.mounted,
        mode: mode ?? this.mode,
        step: step ?? this.step);
  }
}
