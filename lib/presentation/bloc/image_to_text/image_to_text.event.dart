part of 'image_to_text.bloc.dart';

@sealed
final class ImageToTextEvent {}

final class SettingLanguageEvent extends ImageToTextEvent {
  final Lang sourceLang;
  final Lang targetLang;

  SettingLanguageEvent({required this.sourceLang, required this.targetLang});
}

final class CheckModelDownloadedEvent extends ImageToTextEvent {}

final class DownloadModelEvent extends ImageToTextEvent {}

final class SelectImageEvent extends ImageToTextEvent {}

final class UnSelectImageEvent extends ImageToTextEvent {}

final class ChangeSelectedBoxEvent extends ImageToTextEvent {
  final int index;

  ChangeSelectedBoxEvent(this.index);
}

final class TranslateEvent extends ImageToTextEvent {}
