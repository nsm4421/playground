part of 'constant.dart';

enum FeedSearchFields {
  captions(name: "CAPTIONS", iconData: Icons.abc, label: 'Caption'),
  hashtags(name: "HASHTAGS", iconData: Icons.tag, label: 'Hashtag');

  final String name;
  final IconData iconData;
  final String label;

  const FeedSearchFields({
    required this.name,
    required this.iconData,
    required this.label,
  });
}

enum ReelsSearchFields {
  caption("CAPTION");

  final String name;

  const ReelsSearchFields(this.name);
}
