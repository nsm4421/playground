import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:state_management_tutorial/controller/todo_controller.dart';
import 'package:state_management_tutorial/utils/common.dart';
import 'package:state_management_tutorial/utils/w_common.dart';

class HomeScreen extends GetView<ToDoController> {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
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
                      value: (controller.checkedItemIdList.length ==
                          controller.todoVoList.length),
                      onChanged: (e) {
                        if (e == null) return;
                        controller.selectAll(e);
                      }),
                  const Width(width: 10),
                  const Text(
                    "Items",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: controller.deleteSelectedItem,
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
                  itemCount: controller.todoVoList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = controller.todoVoList[index];
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
                          if (e == null) return;
                          controller.check(item, e);
                        },
                        value: controller.checkedItemIdList.contains(item.id),
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

                      /// trailing - 완료여부 버튼
                      trailing: InkWell(
                        onTap: () => controller.handleDone(index),
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
            controller.goToAddPage(context);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
