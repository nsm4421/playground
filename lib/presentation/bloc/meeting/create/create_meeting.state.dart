part of 'create_meeting.cubit.dart';

class CreateMeetingState {
  final Status status;
  final String country;
  late final DateTime startDate;
  late final DateTime endDate;
  final bool isDateSelected;
  final int headCount;
  final AccompanySexType sex;
  final TravelThemeType theme;
  final int minCost;
  final int maxCost;
  final String title;
  final String content;
  late final List<String> hashtags;
  final File? thumbnail;
  final String errorMessage;

  CreateMeetingState(
      {this.status = Status.initial,
      this.country = '',
      DateTime? startDate,
      DateTime? endDate,
      this.isDateSelected = false,
      this.headCount = 2,
      this.sex = AccompanySexType.all,
      this.theme = TravelThemeType.all,
      this.minCost = 10,
      this.maxCost = 500,
      this.title = '',
      this.content = '',
      List<String>? hashtags,
      this.thumbnail,
      this.errorMessage = ''}) {
    this.startDate = startDate ?? DateTime.now();
    this.endDate = endDate ?? DateTime.now();
    this.hashtags = hashtags ?? [];
  }
}
