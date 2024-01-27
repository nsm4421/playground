import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:state_management_tutorial/controller/todo_controller.dart';
import 'package:state_management_tutorial/utils/common.dart';
import 'package:state_management_tutorial/utils/w_common.dart';

class AddToDoScreen extends GetView<ToDoController> {
  AddToDoScreen({super.key});

  final TextEditingController _textEditingController = TextEditingController();

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
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            children: [
              const Height(height: 30),
              InkWell(
                onTap: () {
                  controller.selectDueDay(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Width(width: 20),
                    const Icon(Icons.calendar_month),
                    const Width(width: 5),
                    const Text("언제까지 완료해야 되나요?"),
                    const Spacer(),
                    Text(
                      DateFormat("yyyy/MM/dd")
                          .format(controller.addToDoVo.dueDay),
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
                      value: controller.addToDoVo.type,
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
                          controller.selectDropDownMenu(value);
                        }
                      }),
                  const Spacer(),
                  Text(
                    "${ImportanceType.description(controller.addToDoVo.type)}",
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
                      onChanged: (e) {
                        controller.handleText(e);
                      },
                    ),
                  ),
                  const Width(width: 5),
                  const Width(width: 5),
                ],
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
          onPressed: () {
            controller.addToDo(context);
          },
          child: const Text("ADD")),
    );
  }
}
