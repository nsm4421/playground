import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopUpWidget extends StatelessWidget {
  final String title;
  final String message;
  final Function() okCallback;
  final Function() cancelCallback;

  const PopUpWidget(
      {super.key,
      required this.title,
      required this.message,
      required this.okCallback,
      required this.cancelCallback});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        width: Get.width * 0.7,
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black),
            ),
            Text(
              message,
              style: const TextStyle(fontSize: 14, color: Colors.black),
            ),
            // Buttons
            Row(
              children: [
                ElevatedButton(onPressed: okCallback, child: Text("확인")),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: cancelCallback,
                  child: Text("취소"),
                  style: ElevatedButton.styleFrom(primary: Colors.grey),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
