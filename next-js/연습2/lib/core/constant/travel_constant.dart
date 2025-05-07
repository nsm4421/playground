enum AccompanyType {
  solo(prompt: 'alone', label: 'Alone'),
  family(prompt: 'with family', label: 'Family'),
  friend(prompt: 'with friends', label: 'Friend');

  final String prompt;
  final String label;

  const AccompanyType({required this.prompt, required this.label});
}

enum TendencyType {
  activity(prompt: 'activity', label: 'Activity'),
  history(prompt: 'historic site', label: 'Historic Site'),
  shopping(prompt: 'shopping', label: 'Shopper'),
  recreation(prompt: 'recreation', label: 'Recreation'),
  ;

  final String prompt;
  final String label;

  const TendencyType({required this.prompt, required this.label});
}
