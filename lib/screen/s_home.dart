import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:state_management_tutorial/utils/common.dart';
import 'package:state_management_tutorial/screen/s_add_todo.dart';
import 'package:state_management_tutorial/model/vo_todo.dart';
import 'package:state_management_tutorial/utils/w_common.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// 샘플 데이터
  List<ToDoVo> todoList = [
    ToDoVo(
        dueDay: DateTime.now(),
        text: 'test',
        id: '1',
        status: StatusType.yet,
        type: ImportanceType.urgent),
    ToDoVo(
        dueDay: DateTime.now(), text: 'test', id: '2', status: StatusType.yet),
    ToDoVo(
        dueDay: DateTime.now(), text: 'test', id: '3', status: StatusType.yet),
  ];

  /// 체크한 아이템의 id list
  List<String> checkedItemIdList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// Floating Action 버튼 클릭 시 "할일 추가하기 화면"에서 데이터 받아옴
  _handleGoToAddPage(BuildContext context) async {
    // AddToDo 화면에서 추가한 할일을 받아옴
    final toDoVo = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddToDoScreen(),
      ),
    );
    // State Update
    setState(() {
      todoList.add(ToDoVo.from(toDoVo));
    });
  }

  /// 전체 아이템 선택하기
  void _handleAllCheckBox(bool? e) {
    setState(() {
      if (e == null) {
        return;
      }
      if (e) {
        checkedItemIdList = todoList.map((element) => element.id).toList();
        return;
      }
      if (!e) {
        checkedItemIdList = [];
        return;
      }
    });
  }

  /// 아이템 단건 선택하기
  void _handleCheckBox(ToDoVo item, bool? e) {
    setState(() {
      if (e == null) {
        return;
      }
      if (e) {
        checkedItemIdList.add(item.id);
        return;
      }
      if (!e) {
        checkedItemIdList.remove(item.id);
        return;
      }
    });
  }

  /// 처리여부 아이콘 클릭 시
  void _handleDone(int index, bool done) {
    setState(() {
      todoList[index].status = done ? StatusType.done : StatusType.yet;
    });
  }

  /// 전체 삭제
  void _handleDeleteAll() {
    setState(() {
      todoList.removeWhere((element) => checkedItemIdList.contains(element.id));
      checkedItemIdList = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// App Bar
      appBar: AppBar(
        title: const Text(
          "TODO 앱",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          /// Header
          children: [
            const Height(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Width(width: 15),
                Checkbox(
                    value: (checkedItemIdList.length == todoList.length),
                    onChanged: (e) {
                      _handleAllCheckBox(e);
                    }),
                const Width(width: 10),
                const Text(
                  "Items",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                const Spacer(),
                InkWell(
                  onTap: _handleDeleteAll,
                  child: const Icon(Icons.delete),
                ),
                const Width(width: 25)
              ],
            ),
            const Divider(),

            /// List View
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                shrinkWrap: true, // unbounded height error 피하기 위해서 넣은 설정
                itemCount: todoList.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = todoList[index];
                  // 텍스트 컬러
                  // urgent(중요한 일)면 빨강, asap(가능한 빨리 해야 되는 일)이면 파랑, 아니면 회색
                  Color textColor;
                  switch (item.type) {
                    case (ImportanceType.urgent):
                      textColor = const Color.fromARGB(200, 200, 0, 0);
                      break;
                    case (ImportanceType.asap):
                      textColor = const Color.fromARGB(200, 0, 0, 200);
                      break;
                    default:
                      textColor = const Color.fromARGB(100, 0, 0, 0);
                  }
                  return ListTile(
                    /// check box
                    leading: Checkbox(
                      onChanged: (e) {
                        _handleCheckBox(item, e);
                      },
                      value: checkedItemIdList.contains(item.id),
                    ),

                    /// title - 할일
                    title: Text(
                      item.text,
                      style: TextStyle(
                        decoration: item.status == StatusType.done
                            ? TextDecoration.lineThrough
                            : null,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: textColor,
                      ),
                    ),

                    /// subtitle - Due day
                    subtitle: Text(
                      DateFormat(
                        "yyyy/MM/dd",
                      ).format(item.createdAt),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),

                    /// trailing - 삭제(휴지통) 버튼
                    trailing: InkWell(
                      onTap: () {
                        final isDone = !(item.status == StatusType.done);
                        _handleDone(index, isDone);
                      },
                      child: item.status == StatusType.done
                          ? const Icon(Icons.repeat)
                          : const Icon(Icons.done),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      /// floating action button - "할일 추가하기" 화면으로
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _handleGoToAddPage(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
