import 'package:get/get.dart';
import 'package:state_management_tutorial/controller/todo_controller.dart';

class InitBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ToDoController(), permanent: true);
  }
}
