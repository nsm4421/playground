part of 'edit_diary.bloc.dart';

class EditDiaryState {
  final EditDiaryStep step;
  final Status status;
  final bool update;
  final bool isPrivate;
  final String? location;
  final int currentIndex;
  late final List<DiaryPage> pages;
  late final List<String> hashtags;
  final String errorMessage;

  EditDiaryState(
      {this.step = EditDiaryStep.initializing,
      this.status = Status.initial,
      this.update = false, // true->modify, false->create
      this.isPrivate = true,
      this.location,
      this.currentIndex = 0,
      List<DiaryPage>? pages,
      List<String>? hashtags,
      this.errorMessage = ''}) {
    this.pages = pages ?? [DiaryPage(index: 0)];
    this.hashtags = hashtags ?? [];
  }

  DiaryPage get currentPage => pages[currentIndex];

  bool get isFirstPage => currentIndex == 0;

  bool get isLastPage => currentIndex == pages.length;

  EditDiaryState copyWith({
    EditDiaryStep? step,
    Status? status,
    bool? isPrivate,
    String? location,
    List<DiaryPage>? pages,
    List<String>? hashtags,
    int? currentIndex,
    String? errorMessage,
  }) {
    return EditDiaryState(
        step: step ?? this.step,
        status: status ?? this.status,
        isPrivate: isPrivate ?? this.isPrivate,
        location: location ?? this.location,
        pages: pages ?? this.pages,
        hashtags: hashtags ?? this.hashtags,
        currentIndex: currentIndex ?? this.currentIndex,
        errorMessage: errorMessage ?? this.errorMessage);
  }
}

enum EditDiaryStep {
  initializing,
  editing,
  metaData,
  uploading;
}

class DiaryPage {
  final int index;
  final File? image;
  final String caption;

  DiaryPage({required this.index, this.image, this.caption = ''});

  DiaryPage copyWith({int? index, String? caption}) {
    return DiaryPage(
        index: index ?? this.index,
        image: image,
        caption: caption ?? this.caption);
  }

  DiaryPage copyWithImage(File? image) {
    return DiaryPage(index: index, image: image, caption: caption);
  }
}
