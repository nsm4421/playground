import 'package:state_management_tutorial/common.dart';

class AddToDoVo {
  final DateTime dueDay; // 마감일
  final String text; // 할일
  ImportanceType type;

  AddToDoVo({
    required this.dueDay,
    required this.text,
    this.type = ImportanceType.asap,
  });
}

class ToDoVo extends AddToDoVo {
  final String id;
  final DateTime createdAt;
  StatusType status;

  ToDoVo({
    required super.dueDay,
    required super.text,
    required this.id,
    required this.status,
  }) : createdAt = DateTime.now();

  static ToDoVo from(AddToDoVo vo) {
    return ToDoVo(
      dueDay: vo.dueDay,
      text: vo.text,
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      status: StatusType.yet,
    );
  }
}
