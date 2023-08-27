import 'package:flutter/material.dart';
import 'package:state_management_tutorial/vo_todo.dart';

/// Horizontal Margin
class Width extends StatelessWidget {
  const Width({super.key, required this.width});

  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
    );
  }
}

/// Vertical Margin
class Height extends StatelessWidget {
  const Height({super.key, required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}

/// 아이콘 버튼
class MyIconButton extends StatelessWidget {
  const MyIconButton({super.key, required this.iconData, this.callback});

  final IconData iconData;
  final VoidCallback? callback;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (callback != null) callback!();
      },
      child: Icon(
        iconData,
        size: 25,
      ),
    );
  }
}

/// 할일 아이템 Widget
class ToDoItem extends StatelessWidget {
  const ToDoItem({super.key, required this.todo});

  final ToDoVo todo;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          child: Checkbox(
            value: true,
            onChanged: null,
          ),
        ),
        Text(todo.text),

      ],
    );
  }
}
