import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/screen/main/s_main.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  // 1초동안 splash
  @override
  void initState(){
    delay((){
      Nav.clearAllAndPush(const MainScreen());
    }, 1000.ms);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: Image.asset("/assets/image/splash/splash.png", width: 192,),);
  }
}
