import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:travel/core/generated/assets.gen.dart';
import 'package:travel/core/theme/theme.dart';
import 'package:travel/core/util/extension/extension.dart';
import 'package:travel/domain/entity/auth/presence.dart';
import 'package:travel/domain/entity/reels/reels.dart';
import 'package:travel/presentation/widget/widget.dart';
import 'package:video_player/video_player.dart';

part 's_reels.dart';

part 'f_list.dart';

part 'w_item.dart';

class ReelsPage extends StatelessWidget {
  const ReelsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ReelsScreen();
  }
}
