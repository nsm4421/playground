import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:travel/core/di/dependency_injection.dart';
import 'package:travel/presentation/bloc/image_to_text/image_to_text.bloc.dart';

import '../../core/constant/constant.dart';
import '../widget/widgets.dart';

part 'select_language/setting.screen.dart';

part 'download/download.screen.dart';

part 'select_image/select_image.screen.dart';

part 'translate/translation.screen.dart';

part 'select_image/display_image.fragment.dart';

part 'select_image/guide_text_box.fragment.dart';

part 'select_language/select_lang.widget.dart';

part 'translate/translation_button.widget.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
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
