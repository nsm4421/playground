part of 'cubit.dart';

class EmotionState<RefEntity extends BaseEntity> {
  final RefEntity _ref;
  final Status status;
  final Emotions emotion;
  final String message;

  EmotionState(this._ref,
      {this.status = Status.initial,
      this.emotion = Emotions.none,
      this.message = ''});

  EmotionState<RefEntity> copyWith(
      {Status? status, Emotions? emotion, String? message}) {
    return EmotionState(this._ref,
        status: status ?? this.status,
        emotion: emotion ?? this.emotion,
        message: message ?? this.message);
  }
}
