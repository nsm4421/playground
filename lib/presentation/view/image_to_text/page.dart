import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel/core/di/dependency_injection.dart';
import 'package:travel/core/util/util.dart';
import 'package:travel/presentation/bloc/bloc_module.dart';
import 'package:travel/presentation/bloc/image_to_text/image_to_text.bloc.dart';

import '../../../core/constant/constant.dart';

part 's_setting.dart';

part 's_download.dart';

part 's_select_image.dart';

part 's_translation.dart';

part 'f_display_image.dart';

part 'f_guide_text_box.dart';

part 'f_translated_text.dart';

part 'w_select_lang.dart';

part 'w_outline_border.dart';

part 'w_selected_image.dart';

class ImageToTextPage extends StatefulWidget {
  const ImageToTextPage({super.key});

  @override
  State<ImageToTextPage> createState() => _ImageToTextPageState();
}

class _ImageToTextPageState extends State<ImageToTextPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => getIt<BlocModule>().image2Text,
        child: BlocBuilder<ImageToTextBloc, ImageToTextState>(
            builder: (context, state) {
          return switch (state.step) {
            ImageToTextStep.setting => const SettingScreen(),
            ImageToTextStep.download => const DownloadScreen(),
            ImageToTextStep.selectImage => const SelectImageScreen(),
            ImageToTextStep.translate => const TranslationScreen(),
          };
        }));
  }
}
