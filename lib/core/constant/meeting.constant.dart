part of 'constant.dart';

// 동행자 성별
enum TravelPeopleSexType {
  all(name: 'all', label: "All"),
  onlyMale(name: 'only_male', label: 'Only Male'),
  onlyFemale(name: 'only_female', label: 'Only Male');

  final String name;
  final String label;

  const TravelPeopleSexType({required this.name, required this.label});
}

// 여행 테마
enum TravelThemeType {
  all(label: 'all'),
  eating(label: '맛집투어'),
  shopping(label: '쇼핑'),
  activity(label: '액티비티'),
  hocance(label: '호캉스'),
  historic(label: '유적지');

  final String label;

  const TravelThemeType({required this.label});
}
