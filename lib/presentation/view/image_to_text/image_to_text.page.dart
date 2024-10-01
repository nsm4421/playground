import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel/core/di/dependency_injection.dart';
import 'package:travel/presentation/bloc/image_to_text/image_to_text.bloc.dart';

import '../../../core/constant/constant.dart';

part 'select_language/setting.screen.dart';

part 'download/download.screen.dart';

part 'select_image/select_image.screen.dart';

part 'translate/translation.screen.dart';

part 'select_image/display_image.fragment.dart';

part 'select_image/guide_text_box.fragment.dart';

part 'translate/translated_text.fragment.dart';

part 'select_language/select_lang.widget.dart';

part 'widget/outline_border.widget.dart';

part 'widget/selected_image.widget.dart';

class ImageToTextPage extends StatefulWidget {
  const ImageToTextPage({super.key});

  @override
  State<ImageToTextPage> createState() => _ImageToTextPageState();
}

class _ImageToTextPageState extends State<ImageToTextPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => getIt<ImageToTextBloc>(),
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
