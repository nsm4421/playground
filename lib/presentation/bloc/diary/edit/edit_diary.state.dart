part of 'edit_diary.bloc.dart';

class EditDiaryState {
  final Status status;
  final bool update;
  final bool isPrivate;
  final String content;
  final String location;
  late final List<DiaryAsset> assets;
  late final List<String> hashtags;
  final String errorMessage;

  EditDiaryState(
      {this.status = Status.initial,
      this.update = false, // true->modify, false->create
      this.isPrivate = true,
      this.location = '',
      this.content = '',
      List<DiaryAsset>? assets,
      List<String>? hashtags,
      this.errorMessage = ''}) {
    this.assets = assets ?? [];
    this.hashtags = hashtags ?? [];
  }

  EditDiaryState copyWith({
    Status? status,
    bool? isPrivate,
    String? content,
    String? location,
    List<DiaryAsset>? assets,
    List<String>? hashtags,
    int? currentIndex,
    String? errorMessage,
  }) {
    return EditDiaryState(
        status: status ?? this.status,
        isPrivate: isPrivate ?? this.isPrivate,
        content: content ?? this.content,
        location: location ?? this.location,
        assets: assets ?? this.assets,
        hashtags: hashtags ?? this.hashtags,
        errorMessage: errorMessage ?? this.errorMessage);
  }
}

class DiaryAsset {
  final File image;
  final String caption;

  DiaryAsset({required this.image, required this.caption});

  DiaryAsset copyWith({File? image, String? caption}) {
    return DiaryAsset(
        image: image ?? this.image, caption: caption ?? this.caption);
  }
}
