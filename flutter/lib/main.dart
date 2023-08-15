import 'package:flutter/material.dart';
import 'package:flutter_prj/screen/custom_design/theme.dart';
import 'package:flutter_prj/screen/pages/home/home_page.dart';
import 'package:flutter_prj/view_model/composition_root.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CompositionRoot.configure();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Chat App",
        debugShowCheckedModeBanner: false,
        theme: lightTheme(context),
        darkTheme: darkTheme(context),
        // home: CompositionRoot.composeOnBoardingUi());
        home: CompositionRoot.composeHomeUi());
  }

  const MyApp({key}) : super(key: key);
}
