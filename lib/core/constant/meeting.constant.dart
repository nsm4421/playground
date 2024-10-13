part of 'constant.dart';

// 동행자 성별
enum TravelPeopleSexType {
  onlyMale('only_male'),
  onlyFemale('only_female'),
  all('all');

  final String name;

  const TravelPeopleSexType(this.name);
}

// 동행자 성별
enum TravelPreferenceType {
  eating('맛집투어'),
  shopping('쇼핑'),
  activity('액티비티'),
  hocance('호캉스'),
  historic('유적지'),
  all('all');

  final String label;

  const TravelPreferenceType(this.label);
}
