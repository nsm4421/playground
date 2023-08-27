import 'package:flutter/material.dart';

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

enum ImportanceType {
  urgent("완전 급함"), // 완전 급한
  asap("가능한 빨리"), // 가능한 빨리 (as soon as possible)
  bagOfTime("하나도 안 급함"); // 안급함

  final String _description;

  const ImportanceType(this._description);

  static getByName(String name) => ImportanceType.values
      .firstWhere((e) => e.name == name, orElse: () => ImportanceType.asap);

  static description(ImportanceType type) => type._description;
}
