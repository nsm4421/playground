import 'package:state_management_tutorial/common.dart';

class AddToDoVo {
  final DateTime dueDay; // 마감일
  final String text; // 할일
  final ImportanceType? type;

  AddToDoVo({
    required this.dueDay,
    required this.text,
    this.type,
  });
}
