import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel/core/di/dependency_injection.dart';
import 'package:travel/core/util/util.dart';
import 'package:travel/presentation/cubit/translation/image_to_text.cubit.dart';

part 'index.screen.dart';

part 'selected_image.fragment.dart';

part 'extracted_text.fragment.dart';

part 'outline_border.widget.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => getIt<ImageToTextCubit>(), child: const IndexScreen());
  }
}
