import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sns/c_auth.dart';
import 'package:flutter_sns/firebase_options.dart';
import 'package:flutter_sns/model/vo_user.dart';
import 'package:flutter_sns/screen/auth/s_sign_in.dart';
import 'package:flutter_sns/screen/auth/s_sign_up.dart';
import 'package:flutter_sns/screen/s_app.dart';
import 'package:flutter_sns/util/init_binding.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends GetView<AuthController> {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            titleTextStyle: TextStyle(color: Colors.black)),
        useMaterial3: true,
      ),
      initialBinding: InitBinding(),
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (BuildContext _, AsyncSnapshot<User?> user) {
            // not sign in → show login page
            if (!user.hasData) return SignInScreen();
            // sign → show app
            return FutureBuilder<UserVo?>(
                future: controller.loginUser(user.data!.uid),
                builder: (BuildContext context, snapshot) {
                  return Obx(() =>
                      (controller.user.value.uid != null) & (snapshot.hasData)
                          ? AppScreen()
                          : SignUpScreen(uid: user.data!.uid));
                });
          }),
    );
  }
}
