part of 'display_diary.bloc.dart';

class DisplayDiaryState {
  final Status status;
  final bool isFetching;
  final bool isEnd;
  late final List<DiaryEntity> diaries;
  final String errorMessage;

  DisplayDiaryState(
      {this.status = Status.initial,
      this.isFetching = false,
      this.isEnd = false,
      List<DiaryEntity>? diaries,
      this.errorMessage = ''}) {
    this.diaries = diaries ?? [];
  }

  // created_at필드가 beforeAt보다 작은 레코드만 fetch하기 위한 필드
  String get beforeAt {
    final now = DateTime.now().toUtc().toIso8601String();
    try {
      return diaries.isEmpty
          ? now
          : diaries
              .map((item) => item.createdAt)
              .where((item) => item != null)
              .reduce((v, e) => v!.isBefore(e!) ? v : e)!
              .toIso8601String();
    } catch (error) {
      customUtil.logger.e(error);
      return now;
    }
  }

  DisplayDiaryState copyWith(
      {Status? status,
      bool? isFetching,
      bool? isEnd,
      List<DiaryEntity>? diaries,
      DateTime? beforeAt,
      String? errorMessage}) {
    return DisplayDiaryState(
        status: status ?? this.status,
        isFetching: isFetching ?? this.isFetching,
        isEnd: isEnd ?? this.isEnd,
        diaries: diaries ?? this.diaries,
        errorMessage: errorMessage ?? this.errorMessage);
  }
}
