part of '../export.bloc.dart';

class EditFeedState extends SimpleBlocState {
  final String content;
  late final List<File> files;
  late final List<String> hashtags;

  // 피드 저장할 수 있는 상태인지 여부
  bool get canSubmit => content.trim().isNotEmpty && files.isNotEmpty;

  EditFeedState(
      {super.status,
      super.errorMessage,
      this.content = '',
      List<File>? files,
      List<String>? hashtags}) {
    this.files = files ?? [];
    this.hashtags = hashtags ?? [];
  }

  @override
  EditFeedState copyWith({
    Status? status,
    String? errorMessage,
    String? content,
    List<File>? files,
    List<String>? hashtags,
  }) {
    return EditFeedState(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        content: content ?? this.content,
        files: files ?? this.files,
        hashtags: hashtags ?? this.hashtags);
  }
}
