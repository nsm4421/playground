import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:state_management_tutorial/model/vo_todo.dart';
import 'package:state_management_tutorial/screen/s_add_todo.dart';
import 'package:state_management_tutorial/utils/common.dart';

class ToDoController extends GetxController {
  // 선택한 할일
  final RxList<String> _checkedItemIdList = <String>[].obs;

  List<String> get checkedItemIdList => _checkedItemIdList;

  // 할일 목록
  final RxList<ToDoVo> _todoVoList = <ToDoVo>[].obs;

  List<ToDoVo> get todoVoList => _todoVoList;

  // 추가할 할일
  final RxList<AddToDoVo> _addToDoVoList = <AddToDoVo>[].obs;

  AddToDoVo get addToDoVo => _addToDoVoList[0];

  /// 할일 추가하기 화면으로 이동하기
  goToAddPage(BuildContext context) {
    _addToDoVoList.add(AddToDoVo(dueDay: DateTime.now(), text: ''));
    Get.to(() => AddToDoScreen());
  }

  /// DropDown 메뉴(중요도) 선택
  void selectDropDownMenu(ImportanceType type) {
    print(type);
    _addToDoVoList[0].type = type;
    print(_addToDoVoList[0].type);
  }

  /// 마감일 선택하기
  void selectDueDay(BuildContext context) async {
    await showDatePicker(
      context: context,
      initialDate: _addToDoVoList[0].dueDay,
      firstDate: DateTime.now().subtract(
        const Duration(days: 30),
      ),
      lastDate: DateTime.now().add(
        const Duration(days: 1000),
      ),
    ).then((value) {
      if (value != null) _addToDoVoList[0].dueDay = value;
    });
  }

  /// 할일 입력
  void handleText(String e) {
    _addToDoVoList[0].text = e;
  }

  /// 전체 아이템 선택하기
  void selectAll(bool e) {
    if (e) {
      _checkedItemIdList.value =
          todoVoList.map((element) => element.id).toList();
    }
    if (!e) _checkedItemIdList.value = [];
  }

  /// 선택된 아이템 삭제하기
  void deleteSelectedItem() {
    for (var id in _checkedItemIdList) {
      _todoVoList.removeWhere((element) => element.id == id);
    }
    _checkedItemIdList.value = [];
  }

  /// 아이템 단건 선택하기
  void check(ToDoVo item, bool e) {
    if (e) {
      _checkedItemIdList.add(item.id);
      return;
    }
    if (!e) {
      _checkedItemIdList.remove(item.id);
      return;
    }
  }

  /// 완료여부 변경하기
  void handleDone(int index) {
    final newList = [..._todoVoList];
    newList[index].status = StatusType.getOpposite(_todoVoList[index].status);
    _todoVoList.value = newList;
  }

  /// 할일 추가하기
  void addToDo(BuildContext context) {
    if (_addToDoVoList.value[0].text == '') {
      showDialog(
          context: context,
          builder: (BuildContext ctx) => const AlertDialog(
                elevation: 0,
                content: Text("할일을 입력해주세요"),
                title: Text("Alert"),
              ));
      return;
    }
    _todoVoList.add(ToDoVo.from(_addToDoVoList.value[0]));
    Navigator.pop(context);
  }
}
