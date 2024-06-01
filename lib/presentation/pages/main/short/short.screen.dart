import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constant/routes.dart';

class ShortScreen extends StatelessWidget {
  const ShortScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SHORT"),
        actions: [
          IconButton(onPressed: (){
            context.push("/${Routes.uploadShort.path}");
          }, icon: Icon(Icons.upload))
        ],
      ),
    );
  }
}
