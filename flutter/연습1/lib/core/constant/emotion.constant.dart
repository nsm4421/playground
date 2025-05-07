part of 'constant.dart';

enum Emotions {
  like('LIKES'),
  hate('HATES'),
  none('NONE')
  ;

  final String name;

  const Emotions(this.name);
}
