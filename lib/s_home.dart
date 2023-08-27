import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:state_management_tutorial/common.dart';
import 'package:state_management_tutorial/s_add_todo.dart';
import 'package:state_management_tutorial/vo_todo.dart';
import 'package:state_management_tutorial/w_common.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ToDoVo> todoList = [
    ToDoVo(
        dueDay: DateTime.now(), text: 'test', id: '1', status: StatusType.yet),
    ToDoVo(
        dueDay: DateTime.now(), text: 'test', id: '2', status: StatusType.yet),
    ToDoVo(
        dueDay: DateTime.now(), text: 'test', id: '3', status: StatusType.yet),
  ];

  List<String> checkedItemIdList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// Floating Action 버튼 클릭 시
  _handleGoToAddPage(BuildContext context) async {
    // AddToDo 화면에서 추가한 할일을 받아옴
    final toDoVo = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddToDoScreen(),
      ),
    );
  }

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

  void _handleDone(int index, bool done) {
    setState(() {
      todoList[index].status = done ? StatusType.done : StatusType.yet;
    });
  }

  void _handleDeleteAll() {
    setState(() {
      todoList.removeWhere((element) => checkedItemIdList.contains(element.id));
      checkedItemIdList = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Spacer(),
                InkWell(
                  onTap: _handleDeleteAll,
                  child: const Icon(Icons.delete),
                ),
                const Width(width: 25)
              ],
            ),
            const Divider(),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: todoList.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = todoList[index];
                  return ListTile(
                    leading: Checkbox(
                      onChanged: (e) {
                        _handleCheckBox(item, e);
                      },
                      value: checkedItemIdList.contains(item.id),
                    ),
                    title: Text(
                      item.text,
                      style: TextStyle(
                          decoration: item.status == StatusType.done
                              ? TextDecoration.lineThrough
                              : null,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: (item.status == StatusType.done
                              ? Colors.grey
                              : Colors.redAccent)),
                    ),
                    trailing: InkWell(
                      onTap: () {
                        final isDone = !(item.status == StatusType.done);
                        _handleDone(index, isDone);
                      },
                      child: item.status == StatusType.done
                          ? const Icon(Icons.repeat)
                          : const Icon(Icons.done),
                    ),
                    subtitle: Text(
                      DateFormat(
                        "yyyy/MM/dd",
                      ).format(item.createdAt),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
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
