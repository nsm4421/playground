import 'package:uuid/uuid.dart';

class UuidUtil {
  static String uuid() => (const Uuid()).v4();
}
