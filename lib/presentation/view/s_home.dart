import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:travel/core/util/extension/extension.dart';

import '../../core/generated/assets.gen.dart';

part 'w_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late RiveAnimationController _buttonController;

  @override
  void initState() {
    super.initState();
    _buttonController = OneShotAnimation('active', autoplay: false);
  }

  @override
  void dispose() {
    super.dispose();
    _buttonController.dispose();
  }

  _handleButtonActive() {
    _buttonController.isActive = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// 배경
          RiveAnimation.asset(Assets.rive.shapes),
          Positioned.fill(
              child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 15),
                  child: const SizedBox())),

          SafeArea(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),

              /// 제목
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Karma',
                        style: context.textTheme.displayLarge,
                      ),
                      (24.0).h,
                      Text(
                        'welcome to my dating app',
                        style: context.textTheme.titleLarge
                            ?.copyWith(fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ),

              const Spacer(flex: 2),

              /// 로그인 버튼
              GestureDetector(
                onTap: _handleButtonActive,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: SizedBox(
                    width: 260,
                    height: 64,
                    child: Stack(
                      children: [
                        RiveAnimation.asset(
                          Assets.rive.button,
                          controllers: [_buttonController],
                        ),
                        Positioned.fill(
                            top: 8,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.arrow_forward, size: 30),
                                (12.0).w,
                                Text(
                                  "Let's go",
                                  style: context.textTheme.titleLarge,
                                ),
                              ],
                            ))
                      ],
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 36, left: 24),
                child: Text(
                  'To start, click the button',
                  style: context.textTheme.labelLarge,
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
