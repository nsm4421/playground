import 'package:hive_flutter/hive_flutter.dart';

mixin BoxMixin<T> {
  late final String boxName;
  bool _isInitialized = false;
  late Box<T> _$box;

  Future<Box<T>> getBox() async {
    if (!_isInitialized) {
      _$box = await Hive.openBox(boxName);
    }
    _isInitialized = true;
    return _$box;
  }
}
