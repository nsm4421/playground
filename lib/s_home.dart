import 'package:flutter/material.dart';
import 'package:state_management_tutorial/s_add_todo.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  /// Floating Action 버튼 클릭 시
  _handleGoToAddPage(BuildContext context) async{
    // AddToDo 화면에서 추가한 할일을 받아옴 
    final toDoVo = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddToDoScreen(),
      ),
    );
    // 할일 업데이트
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
