part of 'constant.dart';

// 동행자 성별
enum AccompanySexType {
  all(name: 'all', label: "All"),
  onlyMale(name: 'onlyMale', label: '남자끼리'),
  onlyFemale(name: 'onlyFemale', label: '여자끼리');

  final String name;
  final String label;

  const AccompanySexType({required this.name, required this.label});
}

// 여행 테마
enum TravelThemeType {
  all(label: 'All'),
  eating(label: '맛집투어'),
  shopping(label: '쇼핑'),
  activity(label: '액티비티'),
  hocance(label: '호캉스'),
  historic(label: '유적지');

  final String label;

  const TravelThemeType({required this.label});
}

class MeetingSearchOption {
  final AccompanySexType sex;
  final TravelThemeType theme;
  final String hashtag;

  MeetingSearchOption(
      {this.sex = AccompanySexType.all,
      this.theme = TravelThemeType.all,
      this.hashtag = ''});

  MeetingSearchOption copyWith(
          {String? hashtag, AccompanySexType? sex, TravelThemeType? theme}) =>
      MeetingSearchOption(
          hashtag: hashtag ?? this.hashtag,
          sex: sex ?? this.sex,
          theme: theme ?? this.theme);

  bool get isEmpty =>
      sex == AccompanySexType.all &&
      theme == TravelThemeType.all &&
      hashtag.trim().isEmpty;
}
