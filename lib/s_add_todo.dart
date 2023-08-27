import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:state_management_tutorial/vo_todo.dart';
import 'package:state_management_tutorial/common.dart';

class AddToDoScreen extends StatefulWidget {
  const AddToDoScreen({super.key});

  @override
  State<AddToDoScreen> createState() => _AddToDoScreenState();
}

class _AddToDoScreenState extends State<AddToDoScreen> {
  late DateTime _dueDay;
  late ImportanceType _type;
  late TextEditingController _textEditingController;
  final node = FocusNode();

  @override
  void initState() {
    super.initState();
    _dueDay = DateTime.now();
    _textEditingController = TextEditingController();
    _type = ImportanceType.asap;
  }

  /// Due day 선택하기
  void _selectDate() async {
    await showDatePicker(
      context: context,
      initialDate: _dueDay,
      firstDate: DateTime.now().subtract(
        const Duration(days: 30),
      ),
      lastDate: DateTime.now().add(
        const Duration(days: 1000),
      ),
    ).then((value) => {
          if (value != null)
            {
              setState(() {
                _dueDay = value;
              })
            }
        });
  }

  /// ADD 버튼 클릭시
  void _clickAddButton() {
    // 할일을 입력하지 않은 경우 Alert창 보여주기
    final todo = _textEditingController.text;
    if (todo == '') {
      showDialog(
          context: context,
          builder: (BuildContext ctx) => const AlertDialog(
                elevation: 0,
                content: Text("할일을 입력해주세요"),
                title: Text("Alert"),
              ));
      return;
    }
    // 이전 화면으로 할일 객체 넘겨주기
    Navigator.pop(
        context, AddToDoVo(dueDay: _dueDay, text: _textEditingController.text, type: _type));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "TODO 추가하기",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Height(height: 30),
            InkWell(
              onTap: _selectDate,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Width(width: 20),
                  const Icon(Icons.calendar_month),
                  const Width(width: 5),
                  const Text("언제까지 완료해야 되나요?"),
                  const Spacer(),
                  Text(
                    DateFormat("yyyy/MM/dd").format(_dueDay),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                      fontSize: 18,
                    ),
                  ),
                  const Width(width: 20),
                ],
              ),
            ),
            const Height(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Width(width: 20),
                DropdownButton(
                    value: _type,
                    items: ImportanceType.values
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(e.name),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _type = value;
                        });
                      }
                    }),
                const Spacer(),
                Text(
                  "${ImportanceType.description(_type)}",
                  style: const TextStyle(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const Width(
                  width: 20,
                ),
              ],
            ),
            const Height(height: 50),
            Row(
              children: [
                const Width(width: 20),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(hintText: "할일을 적어주세요"),
                    controller: _textEditingController,
                    focusNode: node,
                  ),
                ),
                const Width(width: 5),
                const Width(width: 5),
              ],
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:
          ElevatedButton(onPressed: _clickAddButton, child: const Text("ADD")),
    );
  }
}
